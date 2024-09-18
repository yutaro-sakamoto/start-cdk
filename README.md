# 個人用AWS CDKテンプレート

AWS CDKプロジェクトを始めるにあたってのテンプレートです。
CDKの設定だけでなく、GitHub Actionsの設定も含まれています。

# 前提条件

- AWSアカウントとAWS CDK(Typescript)が使用可能なこと
  - [AWS CDKの開始方法](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/getting_started.html)
- Gitがインストールされていること
- GitHubアカウントがあること

# 初期設定

このテンプレートを使って新しいCDKプロジェクトを始めるには、以下の手順に従ってください。

## 新しい空のGitHubリポジトリを作成する

WebブラウザまたはGitHub CLIを使って新しい空のプロジェクトを作成してください。
基本的にはプライベートリポジトリを作成することをお勧めします。

## Open ID Connectの設定

> [!CAUTION]
> この手順にミスが有ると、不正なユーザがAWSリソースにアクセスできる可能性があります。
> 信頼ポリシーの設定に誤字がないか、慎重に設定してください。

下記のような信頼ポリシーのIAMロールを作成する。
IAMポリシーはPowerUserAccessなどの適当な権限を持つポリシーを指定してください。

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<AWSアカウントID>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:<GitHubのユーザ名>/<GitHubリポジトリ名>:*"
        }
      }
    }
  ]
}
```

## シークレットの設定

下記の秘密情報をGitHub ActionsのSecretsに設定してください。
Secretsの設定方法は[公式ドキュメント](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository)を参照してください。

| シークレット名 | 説明                                      |
| -------------- | ----------------------------------------- |
| AWS_ID         | デプロイ先のAWSアカウントのID             |
| ROLE_NAME      | Open ID Connectの設定時に作成したロール名 |

## このリポジトリをクローンし、空のリポジトリにプッシュする

以下のコマンドを実行して、このリポジトリをクローンし、新しいリポジトリにプッシュしてください。

```bash
git clone https://github.com/yutaro-sakamoto/start-cdk.git
cd start-cdk
rm -rf .git
git init
git remote add origin <新しいリポジトリのURL>
git br -m main
git add .
git commit -m "Initial commit"
git push origin main
```

これにより、空のスタックがAWSにデプロイされます。

# その他の設定(任意)

その他やっておくと

## .git/hooks/pre-commitの追加

**執筆中**

## mainブランチの保護

**執筆中**

## Visual Studio Codeの拡張機能の設定

**執筆中**

## スタックのリネーム

# 開発フロー

**執筆中**
