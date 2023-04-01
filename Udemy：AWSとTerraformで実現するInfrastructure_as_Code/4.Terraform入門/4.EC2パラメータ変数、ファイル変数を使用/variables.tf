#変数ファイル

#この設定がないとデフォルトが機能しない。
variable "spec_variable" {
  type    = string
  default = "default-spec-value"
}

variable "tag_name" {
  type    = string
  default = "hello-world-variable"
}
