use chrono::NaiveDateTime;
use std::{env, ops::Not};
use walkdir::WalkDir;

fn main() {
    let args: Vec<String> = env::args().collect();

    let default_target = "pinsky_three".to_string();

    let target_dir = args.get(1).unwrap_or(&default_target);

    println!("target_dir: {:?}", target_dir);

    let csv_file_path = format!("{}.csv", target_dir);

    let mut csv_wtr = csv::Writer::from_path(csv_file_path).unwrap();

    csv_wtr.write_record(["datetime", "content"]).unwrap();

    for entry in WalkDir::new(target_dir).into_iter().filter_entry(|e| {
        let path = e.path();
        let is_dir = path.is_dir();
        let is_json = path.extension().map_or(false, |ext| ext == "json");

        is_dir || is_json
    }) {
        let entry = entry.unwrap();
        let path = entry.path();

        if path.is_dir().not() {
            let filename = path.file_name().unwrap().to_str().unwrap();

            if filename.ends_with("_UTC.json") {
                let timestamp = filename.strip_suffix("_UTC.json").unwrap();
                // println!("timestamp: {:?}", timestamp);

                // parse `2024-10-29_17-49-42` as DateTime<Utc>

                // let parts: Vec<&str> = timestamp.split('_').collect();

                // let date = parts.get(0).unwrap();
                // let time = parts.get(1).unwrap();

                // let date_parts: Vec<&str> = date.split('-').collect();
                // let year = date_parts.get(0).unwrap();
                // let month = date_parts.get(1).unwrap();
                // let day = date_parts.get(2).unwrap();

                // let time_parts: Vec<&str> = time.split('-').collect();
                // let hour = time_parts.get(0).unwrap();
                // let minute = time_parts.get(1).unwrap();
                // let second = time_parts.get(2).unwrap();

                let datetime = NaiveDateTime::parse_from_str(timestamp, "%Y-%m-%d_%H-%M-%S")
                    .unwrap()
                    .and_utc();

                println!("datetime: {:?}", datetime);

                let f = filename.strip_suffix(".json").unwrap();
                let ff = format!("{}.txt", f);

                let txt_path = path.with_file_name(ff);

                let txt_content = std::fs::read_to_string(txt_path).unwrap();

                csv_wtr
                    .write_record(&[datetime.to_rfc3339(), txt_content])
                    .unwrap();

                // csv_wtr.write_record(&[datetime.to_rfc3339()]).unwrap();
            }
        }
    }

    csv_wtr.flush().unwrap();

    // println!("Hello, world!");
}
