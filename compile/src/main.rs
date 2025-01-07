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

                let datetime = NaiveDateTime::parse_from_str(timestamp, "%Y-%m-%d_%H-%M-%S")
                    .unwrap()
                    .and_utc();

                // println!("datetime: {:?}", datetime);

                let base_filename = filename.strip_suffix(".json").unwrap();

                let txt_filename = format!("{}.txt", base_filename);
                let txt_path = path.with_file_name(txt_filename);
                let txt_content = std::fs::read_to_string(txt_path).unwrap();

                csv_wtr
                    .write_record(&[datetime.to_rfc3339(), txt_content])
                    .unwrap();
            }
        }
    }

    csv_wtr.flush().unwrap();
}
