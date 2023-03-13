# Docker Operation Images

A collection of Docker Ops Images (based on my experiences)

## Images

**To do**

## Tools installed

All images have [these tools installed](./scripts/requirements.sh)

Then, specifically, the following tools are installed.

| Software Installed | Version |
|-----|-----|
| [Openjdk](https://openjdk.org/) | 11 (UBUNTU release) |
| [Sonar Scanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) | 4.6.0.2311 |
| [OWASP Dependency Check](https://jeremylong.github.io/DependencyCheck/) | 7.0.1 |
| [Checkmarx KICS](https://kics.io/) | 1.5.5 | :heavy_check_mark: | 
| [Chef InSpec](https://www.chef.io/products/chef-inspec) | [always latest version](https://docs.chef.io/inspec/install/#cli-1) |
| [GO lang SDK](https://go.dev/) | 1.16.15 |
| [Apache Maven](https://maven.apache.org/) | 3.6.* (Ubuntu release) |
| [Kubectl]() | **to_insert** |
| [Helm]() | **to_insert** |
| [FluxCD]() | **to_insert** |
| [Azure CLI]() | **to_insert** |
| [Homebrew]() | **to_insert** |

---

### To Do

- [ ] Improve docker versioning
- [ ] Improve documentations
- [ ] Install tools "manually" (without apt-get or auto-install scripts)
- [ ] Improve docs with use-cases
- [ ] Python OPS Image
- [ ] Ruby OPS Image
- [ ] C/C++/C# OPS Image
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
