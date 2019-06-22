use git2::{Error, Repository};

pub struct Remote {
    pub owner: String,
    pub repo: String,
}

pub fn origin_remote<'a>(repo: &'a Repository) -> Result<Remote, Error> {
    if repo.is_bare() {
        return Err(Error::from_str("cannot report status on bare repository"));
    }

    let remote = repo.find_remote("origin")?;
    let name = remote.url().unwrap();
    let path: Vec<&str> = name.split(":").last().unwrap().split("/").collect();

    return Ok(Remote {
        owner: path[0].into(),
        repo: path[1].split(".").nth(0).unwrap().into(),
    });
}

pub fn current_branch<'a>(repo: &'a Repository) -> Result<String, Error> {
    if repo.is_bare() {
        return Err(Error::from_str("cannot report status on bare repository"));
    }

    let head = repo.head()?;
    let name = head.shorthand().unwrap();

    return Ok(name.into());
}

pub fn repo<'a>(path: &'a str) -> Result<Repository, Error> {
    return Ok(Repository::open(path)?);
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::path::Path;

    fn create_repo_with_remote() -> Result<Repository, Error> {
        let folder = "./priv/repo_with_remote";

        if Path::new(folder).exists() {
            let repo = Repository::init(folder)?;
            return Ok(repo);
        } else {
            let repo = Repository::init(folder)?;
            repo.remote("origin", "git@github.com:gabrielpoca/dotfiles.git")?;
            return Ok(repo);
        }
    }

    fn create_repo_with_commit() -> Result<Repository, Error> {
        let folder = "./priv/repo_with_commit";

        if Path::new(folder).exists() {
            let repo = Repository::init(folder)?;

            return Ok(repo);
        } else {
            let repo = Repository::init(folder)?;

            let sig = repo.signature()?;
            let tree_id = {
                let mut index = repo.index()?;
                index.write_tree()?
            };
            let tree = repo.find_tree(tree_id)?;
            repo.commit(Some("HEAD"), &sig, &sig, "Initial commit", &tree, &[])?;

            drop(tree);

            return Ok(repo);
        }
    }

    #[test]
    fn returns_the_origin_remote() {
        let repo = create_repo_with_remote().unwrap();
        let remote = origin_remote(&repo).unwrap();

        assert_eq!("gabrielpoca", remote.owner);
        assert_eq!("dotfiles", remote.repo);
    }

    #[test]
    fn returns_the_current_branch() {
        let repo = create_repo_with_commit().unwrap();
        let branch = current_branch(&repo).unwrap();

        assert_eq!("master", branch);
    }
}
