use std::{env, ops::Not};
use walkdir::WalkDir;

fn main() {
    let args: Vec<String> = env::args().collect();

    let default_target = "pinsky_three".to_string();

    let target_dir = args.get(1).unwrap_or(&default_target);

    println!("target_dir: {:?}", target_dir);

    for entry in WalkDir::new(target_dir).into_iter().filter_entry(|e| {
        let path = e.path();
        let is_dir = path.is_dir();
        let is_json = path.extension().map_or(false, |ext| ext == "json");

        is_dir || is_json
    }) {
        // println!("{:?}", entry);

        let entry = entry.unwrap();
        let path = entry.path();

        if path.is_dir().not() {
            // println!("file: {:?}", path);

            let filename = path.file_name().unwrap().to_str().unwrap();
            // println!("filename: {:?}", filename);

            let timestamp = filename.strip_suffix("_UTC.json").unwrap();
            println!("timestamp: {:?}", timestamp);
        }
    }

    // println!("Hello, world!");
}
