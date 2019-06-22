use clap::{App, SubCommand};
use github_rs::client::{Executor, Github};
use serde_json::Value;
use std::env;
use std::fs;
use std::process::Command;
mod git;
mod tmux;

struct PullRequest {
    title: String,
    body: String,
    href: String,
}

fn github_token() -> String {
    let netrc = fs::read_to_string("/Users/gabrielpoca/.netrc").unwrap();
    let password_line = netrc.split("\n").nth(2).unwrap();
    return password_line.split(" ").last().unwrap().into();
}

fn pull_requests_for_current_branch() -> Result<PullRequest, String> {
    let path = env::current_dir().unwrap();
    let path_str = path.to_str().unwrap();
    let repo = git::repo(path_str).unwrap();
    let current_branch = git::current_branch(&repo).unwrap();
    let remote = git::origin_remote(&repo).unwrap();

    let client = Github::new(github_token()).unwrap();
    let pull_requests_endpoint = format!(
        "repos/{}/{}/pulls?head={}:{}",
        remote.owner, remote.repo, remote.owner, current_branch
    );
    let (_headers, _status, json) = client
        .get()
        .custom_endpoint(&pull_requests_endpoint)
        .execute::<Value>()
        .unwrap();
    let pulls = json.unwrap();
    if pulls[0] == Value::Null {
        return Err(format!(
                "Cannot find pull request for branch {}",
                current_branch
        ));
    } else {
        let pull_request = PullRequest {
            title: pulls[0]["title"].as_str().unwrap().into(),
            body: pulls[0]["body"].as_str().unwrap().into(),
            href: pulls[0]["html_url"].as_str().unwrap().into(),
        };
        return Ok(pull_request);
    }
}

fn pull_request_description() -> Result<(), String> {
    let pull = pull_requests_for_current_branch()?;
    println!("{}\n\n{}", pull.title, pull.body);
    return Ok(());
}

fn pull_request_open() -> Result<(), String> {
    let pull = pull_requests_for_current_branch()?;
    println!("opening {}", pull.href);
    let output = Command::new("open").arg(pull.href).output().unwrap();
    assert!(output.status.success());
    return Ok(());
}

fn main() {
    let matches = App::new("GH")
        .about("Personal git helpers")
        .author("Gabriel Poca")
        .subcommand(
            SubCommand::with_name("pr-description")
            .about("If there is a PR from this branch, output its title and body"),
            )
        .subcommand(
            SubCommand::with_name("pr-open")
            .about("If there is a PR from this branch, open it in the browser"),
            )
        .subcommand(
            SubCommand::with_name("tmux-ci-status")
            .about("Print the ci status for the current tmux pane"),
            )
        .get_matches();

    match matches.subcommand_name() {
        Some("pr-description") => {
            if let Err(e) = pull_request_description() {
                println!("{}", e);
            }
        }
        Some("pr-open") => {
            if let Err(e) = pull_request_open() {
                println!("{}", e);
            }
        }
        Some("tmux-ci-status") => {
            if let Err(e) = tmux::ci_status() {
                println!("{}", e);
            }
        }
        Some(&_) => println!("No subcommand was used"),
        None => println!("No subcommand was used"),
    }
}
