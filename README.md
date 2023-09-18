# Docker Operation Images

A ~~collection of~~ Docker Ops Images (base on my work style)

Otherwise previously releases, this repo will create a single image that you can find here: 
https://hub.docker.com/_/lukecottage/ops-image/

## Why this repo

In the last year, for some reasons, I have been bounded to work on Windows Workstation/Laptops, so I lost all my operation that I had on Ubuntu, Fedora or OSX operative systems and I don't like Microsofts features (example: https://apps.microsoft.com/store/detail/ubuntu/9PDXGNCFSCZV).

So I create a Docker image with an UBUNTU LTS Image (22.04 LTS Jammy) that I can run as container/terminal in my laptop without manage an OS multiboot machine.

## Software installed

The images has [these base tools installed](./scripts/requirements.sh)

Then, specifically, the following tools are installed.

| Software Installed | Version |
|-----|-----|
| [Openjdk](https://openjdk.org/) | 11 (UBUNTU release) |
| [Sonar Scanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) | 4.8.0.2856 |
| [OWASP Dependency Check](https://jeremylong.github.io/DependencyCheck/) | 8.3.1 |
| [Checkmarx KICS](https://kics.io/) | 1.5.5 |
| [GO lang SDK](https://go.dev/) | 1.20.5 |
| [Apache Maven](https://maven.apache.org/) | 3.6 (UBUNTU release) |
| [Kubectl](https://kubernetes.io/docs/tasks/tools/) | 1.27.3 |
| [Helm](https://helm.sh/docs/intro/install/) | v3.12.1 |
| [FluxCD](https://fluxcd.io/flux/installation/) | [v2.0.0](https://github.com/fluxcd/flux2/releases/tag/v2.0.0) |
| [Azure CLI](https://learn.microsoft.com/it-it/cli/azure/install-azure-cli-linux?pivots=apt) | Always Latest Version - APT managed by MS repositories |
| [Chef InSpec](https://www.chef.io/products/chef-inspec) | [Always Latest Version](https://docs.chef.io/inspec/install/#cli-1) |
| [Homebrew](https://brew.sh/index_it) | Always Latest Version |
| [SDKMAN](https://sdkman.io/install) | Always Latest Version |

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
- [ ] maybe, Android images(?) (hint: https://github.com/docker-android-sdk)
- [x] include kubernets tools
- [ ] include chaos tools
- [ ] include more CLIs(?)
- [ ] include rundeck(?)
- [ ] include QA scripts

### Refs:

 - https://github.com/docker-android-sdk/android-30
 - https://github.com/Checkmarx/kics
 - https://github.com/github/codeql-action
