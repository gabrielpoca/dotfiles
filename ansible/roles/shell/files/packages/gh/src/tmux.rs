use std::process::Command;

pub fn ci_status() -> Result<(), String> {
    let output = Command::new("tmux")
        .arg("display-message")
        .arg("-p")
        .arg("-F")
        .arg("\"#{pane_current_path}\"")
        .output()
        .unwrap();

    let stdout = output.stdout;

    unsafe {
        let path = String::from_utf8_unchecked(stdout).trim().replace("\"", "");

        if path.is_empty() {
            return Ok(());
        }

        let output = Command::new("hub")
            .current_dir(path)
            .arg("ci-status")
            .output()
            .unwrap();

        let stdout = output.stdout;
        let status = String::from_utf8_unchecked(stdout).trim().replace("\"", "");

        if status.is_empty() {
            return Ok(());
        }

        if status == "no status" {
            return Ok(());
        }

        println!("ᚳ {}", status);
    }

    return Ok(());
}
