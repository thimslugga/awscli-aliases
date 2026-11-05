# My custom awscli-aliases

Repository for my custom AWS CLI aliases.

## Overview

This repository contains a set of aliases for the AWS CLI. The aliases are defined in the ``alias`` file and can be used to simplify the usage of the AWS CLI.

The aliases are defined in INI format, without the leading `aws`:

```ini
whoami = sts get-caller-identity
```

Aliases prefixed with `!` are run as shell commands, which allows defining functions that take arguments:

```ini
list-user-keys =
  !f() {
    aws iam list-access-keys --user-name "$1" --query "AccessKeyMetadata[].AccessKeyId" --output text
  }; f
```

The ``whoami`` alias above can be used to get the account ID, user ID, and ARN of the IAM user whose credentials are being used to run the command.

```shell
aws whoami
```

The above command is equivalent to running:

```shell
aws sts get-caller-identity
```

For more information, see the following documentation: [AWS CLI Alias Usage](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-alias.html)

## Requirements

### AWS CLI

AWS CLI v2 is recommended. Basic aliases work with version ``1.11.24`` or higher, but some aliases (e.g. ``ecs-exec``) require v2.

You can determine the version by running:

```shell
aws --version
```

You can download the latest version of the AWS CLI from the following link: [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/).

### jq

Many of the function aliases (e.g. ``generate-sts-token``, ``assume-role``, ``get-asg-instance-ips``) pipe output through jq. See the jq install instructions below.

### The tostring alias

The tostring alias requires to have the jp command installed.

For installing the command line interface for JMESPath i.e. jp, see: [https://github.com/jmespath/jp](https://github.com/jmespath/jp).

```shell
brew install jp
```

```shell
sudo apt-get install jp
```

### tostring-with-jq alias

The tostring-with-jq alias requires to have the jq command installed.

For installing the command-line JSON processor i.e. jq, see: [https://jqlang.github.io/jq/download/](https://jqlang.github.io/jq/download/).

```shell
brew install jq
```

```shell
sudo apt-get install jq
```

## Getting Started

To start using aliases available in this repository, run the installer:

```shell
curl -fsSL https://raw.githubusercontent.com/thimslugga/awscli-aliases/main/install.sh | bash
```

The installer clones the repository to ``~/.aws/awscli-aliases`` and symlinks ``~/.aws/cli/alias`` to it,
backing up any existing alias file first. Re-run it at any time to pull the latest aliases.

Or install manually:

```shell
git clone https://github.com/thimslugga/awscli-aliases.git
mkdir -p ~/.aws/cli
cp awscli-aliases/alias ~/.aws/cli/alias
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

Contributions are welcome! Please open an issue or pull request.

## License

See the [LICENSE](LICENSE) file.
