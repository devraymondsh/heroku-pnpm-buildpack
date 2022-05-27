# Pnpm heroku buildpack

This buildpack makes it possible to use pnpm on heroku.<br />
This buildpack can detect your project sub-directories so that you can have a multilingual project.

## Using the heroku buildpack

```shell
heroku buildpaks:set https://github.com/devraymondsh/heroku-pnpm-buildpack
```