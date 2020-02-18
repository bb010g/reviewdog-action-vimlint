# action-vimlint

[![Test](https://github.com/bb010g/reviewdog-action-vimlint/workflows/Test/badge.svg)](https://github.com/bb010g/reviewdog-action-vimlint/actions?query=workflow%3ATest)
[![reviewdog](https://github.com/bb010g/reviewdog-action-vimlint/workflows/reviewdog/badge.svg)](https://github.com/bb010g/reviewdog-action-vimlint/actions?query=workflow%3Areviewdog)
[![depup](https://github.com/bb010g/reviewdog-action-vimlint/workflows/depup/badge.svg)](https://github.com/bb010g/reviewdog-action-vimlint/actions?query=workflow%3Adepup)
[![release](https://github.com/bb010g/reviewdog-action-vimlint/workflows/release/badge.svg)](https://github.com/bb010g/reviewdog-action-vimlint/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/bb010g/reviewdog-action-vimlint?logo=github&sort=semver)](https://github.com/bb010g/reviewdog-action-vimlint/releases)
[![action-bumpr supported](https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr)](https://github.com/haya14busa/action-bumpr)

![github-pr-review demo](https://user-images.githubusercontent.com/3797062/73162963-4b8e2b00-4132-11ea-9a3f-f9c6f624c79f.png)
![github-pr-check demo](https://user-images.githubusercontent.com/3797062/73163032-70829e00-4132-11ea-8481-f213a37db354.png)

This action runs [vim-vimlint](https://github.com/syngan/vim-vimlint) with [reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve code review experience.

## Input

### `github_token`

**Optional**
A token to authenticate on behalf of this GitHub App installed on your repository.
Set to a non-standard token.
Defaults to `${{ github.token }}` (`$GITHUB_TOKEN`).

### (reviewdog) `level`

**Optional**
The report level for reviewdog.
Can be one of: `info`, `warning`, or `error`.
Defaults to `error`.

### (reviewdog) `reporter`

**Optional**
The reporter for reviewdog.
Can be one of: `github-pr-check`, `github-check`, or `github-pr-review`.
Defaults to `github-pr-check`.

### (vimlint) `path`

**Optional**
Path to lint.
(The empty string unsets this input.)
At least one of `path` or `paths` should be set.
Defaults to `autoload`.

### (vimlint) `paths`

**Optional**
Additional paths or globs to lint.
Uses Busybox ash syntax.
At least one of `path` or `paths` should be set.

### (vimlint) `only_error`

**Optional**
Whether to only report lint error messages.
Can be one of: `true` or `false`.
Defaults to `false`.

### (vimlint) `verbose`

**Optional**
Whether to lint verbosely.
Can be one of: `true` or `false`.
Defaults to `true`.

### (vimlint) `flags`

**Optional**
Additional vimlint flags.
Uses Busybox ash syntax.

## Usage

```yaml
name: reviewdog
on: [pull_request]
jobs:
  vimlint:
    name: runner / vimlint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: bb010g/reviewdog-action-vimlint@v1
        with:
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
          # If you want to ignore EVL103 for any cases and EVL102 for variable `_`:
          flags: '-e EVL103=1 -e EVL102.l:_=1'
```

## Development

### Release

#### [haya14busa/action-bumpr](https://github.com/haya14busa/action-bumpr)
You can bump version on merging Pull Requests with specific labels (bump:major,bump:minor,bump:patch).
Pushing tag manually by yourself also work.

#### [haya14busa/action-update-semver](https://github.com/haya14busa/action-update-semver)

This action updates major/minor release tags on a tag push. e.g. Update v1 and v1.2 tag when released v1.2.3.
ref: https://help.github.com/en/articles/about-actions#versioning-your-action

### Lint - reviewdog integration

This reviewdog action template itself is integrated with reviewdog to run lints
which is useful for Docker container based actions.

![reviewdog integration](https://user-images.githubusercontent.com/3797062/72735107-7fbb9600-3bde-11ea-8087-12af76e7ee6f.png)

Supported linters:

- [reviewdog/action-shellcheck](https://github.com/reviewdog/action-shellcheck)
- [reviewdog/action-hadolint](https://github.com/reviewdog/action-hadolint)
- [reviewdog/action-misspell](https://github.com/reviewdog/action-misspell)

### Dependencies Update Automation
This repository uses [haya14busa/action-depup](https://github.com/haya14busa/action-depup) to update
reviewdog version.

[![reviewdog depup demo](https://user-images.githubusercontent.com/3797062/73154254-170e7500-411a-11ea-8211-912e9de7c936.png)](https://github.com/reviewdog/action-template/pull/6)
