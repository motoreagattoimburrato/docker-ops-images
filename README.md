# Docker Operation Images

A collection of Docker Ops Images (based on my experiences)

## Images

**To do**

## Tools installed

All images have [these tools installed](./scripts/requirements.sh)

Then, specifically, the following tools are installed.

| Software Installed | Version | Base OPS Image | Full OPS Image | Java OPS Image  | PHP OPS Image |
|-----|-----|-----|-----|-----|-----|
| [Openjdk](https://openjdk.org/) | 11 (UBUNTU release) | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| [Sonar Scanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) | 4.6.0.2311 | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| [OWASP Dependency Check](https://jeremylong.github.io/DependencyCheck/) | 7.0.1 | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| [Checkmarx KICS](https://kics.io/) | 1.5.5 | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| [Chef InSpec](https://www.chef.io/products/chef-inspec) | [always latest version](https://docs.chef.io/inspec/install/#cli-1) | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| [GO lang SDK](https://go.dev/) | 1.16.15 | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| [Apache Maven](https://maven.apache.org/) | 3.6.* (Ubuntu release) | :x: | :heavy_check_mark: | :heavy_check_mark: | :x: |
| [Gradle](https://gradle.org/) | 4.4.* (Ubuntu release) | :x: | :heavy_check_mark: | :heavy_check_mark: | :x: |
| [PHP](https://www.php.net/) | 7.4.* (Ubuntu release) | :x: | :heavy_check_mark: | :x: | :heavy_check_mark: |
| [Composer](https://getcomposer.org) | [always latest version](https://getcomposer.org/doc/00-intro.md) | :x: | :heavy_check_mark: | :x: | :heavy_check_mark: |

---

### To Do

- [ ] Install tools "manually" (without apt-get or auto-install scripts)
- [ ] Improve docs with use-cases
- [ ] Python OPS Image
- [ ] Ruby OPS Image
- [ ] C/C++/C# OPS Image
- [ ] maybe, using SDKMAN(?)
- [ ] maybe, Android images(?) (hint: https://github.com/docker-android-sdk)
- [ ] include kubernets tools
- [ ] include chaos tools
- [ ] include more CLIs(?)
- [ ] include rundeck(?)
- [ ] include QA scripts

### Refs:

 - https://github.com/docker-android-sdk/android-30
 - https://github.com/Checkmarx/kics
 - https://github.com/github/codeql-action
