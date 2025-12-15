#import "../resume-template.typ": *

#let (resume-header, resume-entry) = setup-styles(
  font-size: 13pt, element-spaciness: 1.5,
)
#show: resume-header.with(
  author: "你的名字", 
  telephone: "联系方式", email: "邮箱@edu.cn",
)

= 小节标题
#resume-entry(
  title: "第一个简历项",
  subtitle: "文本1",
  date: "文本2"
)[
  - 这是一个基于 Typst 的中文简历模板
  - 极简，自由书写，轻松排版，高度定制
  - 多种文本样式：_强调_ ; *高亮* ; `monospaced` ; #underline[下划线] ; #link("https://github.com")[超链接]
]

= 工作经历
#resume-entry(
  title: "公司名称",
  subtitle: "岗位名称",
  date: "2025-01 ~ 2025-07",
)[- 完整用例请参考 `demos/luoji.typ` 源文件]
