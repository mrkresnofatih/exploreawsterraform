terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-3"
  profile = "superHero22Admin"
}

variable "projectname" {
  type        = string
  default     = "exploreawsterraform"
  description = "personal project name"
}


resource "aws_iam_user" "awsuser" {
  name = "fatihadmin23"
  tags = {
    projectname = var.projectname
  }
}

resource "aws_iam_user_policy" "awsuserpolicy" {
  name = "${aws_iam_user.awsuser.name}-policy"
  user = aws_iam_user.awsuser.name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "dynamodb:CreateTable",
          "dynamodb:CreateBackup",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}