# awscli-aliases

Repository for AWS CLI aliases.

## Overview

This repository contains a set of aliases for the AWS CLI. The aliases are defined in the ``alias`` file and can be used to simplify the usage of the AWS CLI.

The aliases are defined in the following format:

```shell
alias <alias-name>='<command>'
```

For example:

```shell
alias whoami='aws sts get-caller-identity'
```

The above alias can be used to get the account ID, user ID, and ARN of the IAM user whose credentials are being used to run the command.

```shell
$ aws whoami
```

The above command is equivalent to running:

```shell
$ aws sts get-caller-identity
```

For more information, see the following documentation: [AWS CLI Alias Usage](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-alias.html)

## Requirements

### AWS CLI

Make sure that you are using version ``1.11.24`` or higher of the AWS CLI.

You can download the latest version of the AWS CLI from the following link: [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/).

You can determine the version by running:

```shell
$ aws --version
```

For information on installation and upgrading of the AWS CLI, please refer to the [AWS CLI User Guide](http://docs.aws.amazon.com/cli/latest/userguide/installing.html).

### The tostring alias

The tostring alias requires to have the jp command installed.

For installing the command line interface for JMESPath i.e. jp, see: [https://github.com/jmespath/jp](https://github.com/jmespath/jp).

### tostring-with-jq alias

The tostring-with-jq alias requires to have the jq command installed.

For installing the command-line JSON processor i.e. jq, see: [https://jqlang.github.io/jq/download/](https://jqlang.github.io/jq/download/).

## Getting Started

To start using aliases available in this repository, run the following commands:

```shell
$ git clone
$ mkdir -p ~/.aws/cli
$ cp awscli-aliases/alias ~/.aws/cli/alias
```

To test that the aliases now work, run the following alias:

```shell
aws whoami
```

This should display the same response as the ``aws sts get-caller-identity`` command:

```json
{
  "Account": "012345678901",
  "UserId": "AIUAINBADX2VEG2TC6HD6",
  "Arn": "arn:aws:iam::012345678901:user/myuser"
}
```

## Contributing

Contributions are welcome! For more information, see the [CONTRIBUTING](CONTRIBUTING.md) file.

## License
