<h1 align="center">Article Continuous Integration</h1>

A useful CLI tool for managing article content integrated with a project.

We want to provide a sense of unity as content that users can get by managing it as a project, rather than just a function that allows file specification in a simple code block.If you want to publish a folder or repository where you are managing articles, it is a fact that there is more for users to get if it exists as a single file included in a project, rather than just one file to refer to. I want to provide that.

---

## Contents

- [Features](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#features)
- [Suppoted Languages](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#suppoted-languages)
- [Usage](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#usage)
  - [Create base file](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#create-base-file)
  - [Create article](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#create-article)
  - [Display file name and title](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#display-file-name-and-title)
- [Commands](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#commands)
  - [Options](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#options)
- [Example 1](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#example-1)
- [Example 2](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#example-2)
- [Adding playground URL(Rust only)](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#adding-playground-urlrust-only)
- [Add code blocks together](https://github.com/ogty/continuous-article-integration/blob/main/README-en.md#add-code-blocks-together)

---

## Features

- [x] Create new articles and projects
- [x] Specifying files in code blocks
- [x] Add PlayGround URL to code block(Rust only)
- [x] Code Block Operation

## Suppoted Languages

- C
- C#(cs)
- C++(cpp)
- Go
- Haskell
- Java
- Javascript
- Julia
- Lua
- PHP
- Python
- Rust
- Scala
- Swift
- TypeScript

The `()` is the language of the snippet, all in lowercase.

````md
```cpp:main.cpp
#include <iostream>

using namespace std;

int main() {
  cout << "Hello, world!" << endl;
  return 0;
}
```
````

##### To add a language, you just need to rewrite the program a little.

## Usage

```
$ cargo build
```

The `/target/debug/cai.exe` created by the `cargo build` command should be placed directly under the folder where you maintain your Zenn articles.

### Create base file

```bash
$ cai init <title> <topics> [option]
```

If `-p` is specified for `[option]`, a folder with the same name as the file name will be created directly under `projects`.

```bash
$ cai init -p "This is the title" Topic1 Topic2
```

For example, the above command will create `articles/<uuid>.txt` and `projects/<uuid>`.

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
```

```txt:<uuid>.txt
---
title: This is the title
emoji: 🐒
type: tech
topics: [topic1, topic2]
published: false
---
```

If you don't specify any options, only `articles/<uuid>.txt` will be created. The reason it is a `.txt` file is to prevent it from being recognized as an article and to allow updates to the content; Github gives priority to the `README.md` file over the `README.txt` file.

### Create article

If you run the following command with or without a project, it will create a `<uuid>.md` file. Copying the file name is a pain, but...

```bash
$ cai <path>
```

```
├─images
├─books
├─articles
│  ├─<uuid>.txt
│  └─<uuid>.md
└─projects
   └─<uuid>
```

```md:<uuid>.md
---
title: This is the title
emoji: 🐒
type: tech
topics: [topic1, topic2]
published: false
---
```

It is also possible to run the command to create a new article with just `init` or just `title`.

```bash
$ cai init "This is the title"
```

### Display file name and title

To display the file name and title, execute the following command.

```bash
$ cai show
```

## Commands

It is not necessary to include the extension in the commands or options.

- `init <title> <topics> [option]` : Create a base file
- `show` : Show the file name and title directly under articles
- `<file name>` : Create articles (`.md`)

##### If there is no `<file name>.txt` directly under articles, it will be considered as a relative path.

### Options

- `-p` : Create projects at the same time
- `-n` : Create an empty base file
- `--name <file name>` : Specify any file name
  
## Example 1

Let's say you want to write an article called "Hello, world in Rust!"

```bash
$ cai init -p "Hello, world! in Rust"
```

The folder structure when the above command is executed is as follows.

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
```

Go to `projects/<uuid>` and run the following.

```bash
$ cd projects/<uuid>
$ cargo init --name project
```

Folder structure so far ↓

```
├─images
├─books
├─articles
│  └─<uuid>.txt
└─projects
   └─<uuid>
      ├─src
      │  └─main.rs
      └─Cargo.toml
```

Add a comment to `main.rs`. The `1` part of this comment can be anything, as long as it is the same as in the code block.

```rust:src/main.rs
// 1
fn main() {
    println!("Hello, world!");
}
// -1
```

Add a code snippet to `articles/<uuid>.txt` with the number of the code range you want to display in `main.rs`.

````txt:articles/<uuid>.txt
---
title: Hello, world! in Rust
emoji: 🐒
type: tech
topic: [Rust]
published: false
---

```rust:src/main.rs
1
```
````

Execute the following command.

```bash
$ cai <uuid>
```

Then `articles/<uuid>.md` will be created, and it will have the following contents.

````md:<uuid>.md
---
title: Hello, world! in Rust
emoji: 🐒
type: tech
topic: [Rust]
published: false
---

```rust:src/main.rs
fn main() {
    println!("Hello, world!");
}
```
````

Now you can push to Github and deploy the article by setting `published: true`.

## Example 2

Case where source code in the project is used in README

Folder Configuration ↓

```
└─cai.exe
```

Create the base file, but it is faster to use the `touch` command for this.

```bash
$ cai init --name README -n
$ # touch README.txt
```

If you want to place `cai.exe` on the desktop or some other location for use in other projects, you can solve this by entering a relative path in the `--name` option. In this case, the path specified in the code block in the base file must also be relative to `cai.exe`.

```bash
$ cai init --name ./<folder name>/README -n
```

Folder configuration ↓

```
├─README.txt
└─cai.exe
```

Create a Python program to display "Hello, world!" and comment it.

**`main.py`**

```python
# 1
print("Hello, world!")
# -1
```

**`README.txt`**

````txt
```python:./main.py
1
```
````

Folder structure ↓

```
├─main.py
├─README.txt
└─cai.exe
```

Create an article.

```bash
$ cai README
```

**`README.md`**

````md
```python:./main.py
print("Hello, world!")
```
````

Folder structure ↓

```
├─main.py
├─README.md
├─README.txt
└─cai.exe
```

## Adding playground URL(Rust only)

You can add a Playground URL, which is only available in Rust.

````txt:<uuid>.txt
```rust:src/main.rs:sample code
1
```
````

You can add the Playground URL of the program in the code block by using `<language>:<path>:<string for link>` as above.

````md:<uuid>.md
[sample code](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=fn%20main%28%29%20%7B%0A%20%20%20%20println%21%28%22Hello%2C%20world%21%22%29%3B%0A%7D)

```rust:src/main.rs:sample code
fn main() {
    println!("Hello, world!");
}
```
````

## Add code blocks together

It is possible to combine specific comment-out ranges of files together.

**`src/main.rs`**

```rust
// 1
fn main() {
   hello();
}
// -1
```

**`src/hello.rs`**

```rust
// 1
fn hello() {
   println!("Hello, world!");
}
// -1
```

To combine the comment-out ranges of the two files above, write the following

**`*.txt`**

````txt
```rust```src/main.rs:1 + src/hello.rs:1
````

The codes are merged together in the order in which they are written, starting from the top.

**`*.md`**

````md
```rust
fn main() {
   hello();
}
fn hello() {
   println!("Hello, world!");
}
```
````
