resource "aws_lambda_function" "func" {
    filename = data.archive_file.zip.output_path
    source_code_hash = data.archive_file.zip.output_base64sha256
    function_name = "cloud-test-api"
    role = aws_iam_role.RoleforLambda.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.11"
}

resource "aws_iam_role" "RoleforLambda"{
    name = "DB_permissions"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid":""

    }
  ]
}
    EOF
}

resource "aws_iam_policy" "iam_policy_for_resume_project" {
  name        = "a-new-policy"
  path        = "/"
  description = "AWS IAM policy for managing the resume project role"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogsStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:UpdateItem",
            "dynamodb:GetItem"
          ],
          "Resource" : "arn:aws:dynamodb:*:*:table/Resume-Website-Table"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role = aws_iam_role.RoleforLambda.name
    policy_arn = aws_iam_policy.iam_policy_for_resume_project.arn
}

resource "aws_dynamodb_table" "Resume_Website_Table-test" {
    name = "Resume-Website-Table-test"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "View_Count"

    attribute {
        name = "View_Count"
        type = "S" 
    }
}

data "archive_file" "zip" {
    type = "zip"
    source_dir = "${path.module}/lambda"
    output_path= "${path.module}/packedllambda.zip"
}