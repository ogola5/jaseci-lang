import os;

walker FileExplorer {
    has target_file: str;
    has current_path: list[str] = [];
    has search_depth: int = 0;
    
    can start with `root entry;
    can explore_directory with directory entry;
}

node directory {
    has name: str;
    has file_count: int = 0;
    has max_depth: int = 3;
}

node file {
    has name: str;
    has size: int;
    has extension: str;
}

edge contains;

with entry: __main__ {
    # First set up the file system
    root spawn setup_file_system();
    
    # Then search for files
    root spawn FileExplorer("config.json");
    root spawn FileExplorer("README.md");
    root spawn FileExplorer("main.py");
}

impl FileExplorer.start {
    let root_dirs = [root --> (`?directory)];
    if root_dirs.length == 0 {
        # Create root directory node
        root_dir = root ++> directory(name="root", file_count=0);
    } else {
        root_dir = root_dirs[0];
    }
    self.current_path += [root_dir.name];
    visit root_dir;
}

impl FileExplorer.explore_directory {
    # Check files in current directory
    let file_edges = [-->:contains:--> (`?file)];
    if file_edges.length > 0 {
        for f in file_edges {
            if f.name == self.target_file {
                print(f"Found {self.target_file} at: {'/'.join(self.current_path)}");
                disengage;
            }
        }
    }
    
    # Check for subdirectories
    let dir_edges = [-->:contains:--> (`?directory)];
    if dir_edges.length > 0 and self.search_depth < here.max_depth {
        # Move to subdirectories
        for dir in dir_edges {
            self.search_depth += 1;
            self.current_path += [dir.name];
            visit dir;
        }
    } else {
        # Backtrack or disengage
        let parent_dirs = [<--:contains:--> (`?directory)];
        if parent_dirs.length > 0 {
            self.current_path.pop();
            self.search_depth -= 1;
            visit parent_dirs[0];
        } else {
            print(f"File {self.target_file} not found in file system");
            disengage;
        }
    }
}

walker setup_file_system {
    can start with `root entry;
    impl entry {
        # Create a sample file system structure
        root_dir = root ++> directory(name="root", file_count=3);
        
        # Create files in root
        root_dir ++>:contains:++> file(name="README.md", size=1024, extension="md");
        root_dir ++>:contains:++> file(name="config.json", size=2048, extension="json");
        root_dir ++>:contains:++> file(name="main.py", size=3072, extension="py");
        
        # Create subdirectories
        docs_dir = root_dir ++>:contains:++> directory(name="docs", file_count=2);
        src_dir = root_dir ++>:contains:++> directory(name="src", file_count=2);
        
        # Files in docs
        docs_dir ++>:contains:++> file(name="guide.md", size=512, extension="md");
        docs_dir ++>:contains:++> file(name="api.json", size=1024, extension="json");
        
        # Files in src
        src_dir ++>:contains:++> file(name="utils.py", size=2048, extension="py");
        src_dir ++>:contains:++> file(name="models.py", size=4096, extension="py");
        
        print("File system setup complete");
        disengage;
    }
}