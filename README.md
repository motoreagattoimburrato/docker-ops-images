# Docker Operation Images

A ~~collection of~~ Docker Ops Images (base on my work style)

Otherwise previously releases, this repo will create a single image where you can find here: 
https://hub.docker.com/lukecottage/ops-image/

## Why this repo

In the last year, for some reasons, I have been bounded to work on Windows Workstation/Laptops, so I lost all my operation that I had on Ubuntu, Fedora ora OSX operative systems and I don't like Microsofts solutions (example: https://apps.microsoft.com/store/detail/ubuntu/9PDXGNCFSCZV).

So I create a Docker image that I can run as container/terminal in my laptop without manage an OS multiboot machine.

## Software installed

The images has [these base tools installed](./scripts/requirements.sh)

Then, specifically, the following tools are installed.

| Software Installed | Version |
|-----|-----|
| [Openjdk](https://openjdk.org/) | 11 (UBUNTU release) |
| [Sonar Scanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) | 4.8.0.2856 |
| [OWASP Dependency Check](https://jeremylong.github.io/DependencyCheck/) | 8.3.1 |
| [Checkmarx KICS](https://kics.io/) | 1.5.5 | :heavy_check_mark: | 
| [Chef InSpec](https://www.chef.io/products/chef-inspec) | [always latest version](https://docs.chef.io/inspec/install/#cli-1) |
| [GO lang SDK](https://go.dev/) | 1.20.5 |
| [Apache Maven](https://maven.apache.org/) | 3.6.* (Ubuntu release) |
| [Kubectl]() | **to_insert** |
| [Helm]() | **to_insert** |
| [FluxCD]() | **to_insert** |
| [Azure CLI]() | **to_insert** |
| [Homebrew]() | **to_insert** |

---

## How to use

**to do**

---

### To Do

- [x] Improve docker versioning
- [ ] Improve documentations
- [ ] Install tools "manually" (without apt-get or auto-install scripts)
- [ ] Improve docs with use-cases
- [ ] Improve Python env
- [ ] Install Ruby env
- [ ] Install C/C++/C# env
- [ ] maybe, using SDKMAN(?)
- [ ] maybe, Android images(?) (hint: https://github.com/docker-android-sdk)
- [x] include kubernets tools
- [ ] include chaos tools
- [ ] include more CLIs(?)
- [ ] include rundeck(?)
- [ ] include QA scripts
- [ ] redo php (using SDKMAN)
- [ ] redo java/gradle (using SDKMAN)


### Refs:

 - https://github.com/docker-android-sdk/android-30
 - https://github.com/Checkmarx/kics
 - https://github.com/github/codeql-action
