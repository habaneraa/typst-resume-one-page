#import "@preview/fontawesome:0.5.0": *

// 总计使用三种字体
#let sans-serif-font = ("Source Han Sans SC")
#let serif-font = ("Source Han Serif SC")
#let alt-serif-font = ("LXGW WenKai GB Screen")


#let resume(
  author: "",
  profile-image: "",
  telephone: "",
  email: "",
  github-id: "",
  other-link: "",
  location: "",
  extra-info: "",
  accent-color: rgb("#8758ff"),
  background-color: rgb("#e2e2da"),
  element-spaciness: 1.00,
  body,
) = {
  
  set document(
    author: author, 
    title: author + "个人简历", 
    date: datetime.today()
  )

  // 基础样式
  set page(
    margin: (x: 1.2cm * element-spaciness, y: 1.3cm * element-spaciness), // 页边距
    fill: background-color, // 页面背景色
  )
  set par(
    justify: true,
    leading: 0.5em * element-spaciness, // 行距
    spacing: 0.9em * element-spaciness, // 段间距
  )
  set text(
    font: ( // 这里修一下中文字体里的全角符号
      (name: "Times New Roman", covers: regex("•")),
      serif-font,
    ),
    lang: "zh",
    size: 11pt,     // 全局字号
  )

  // 链接和强调样式
  show link: underline
  show emph: underline
  show link: set text(fill: accent-color)
  show strong: set text(fill: accent-color, font: sans-serif-font)
  show emph: set text(weight: "black")

  // 小节标题样式 带横线
  show heading: it => {
    text(
      fill: accent-color,
      font: sans-serif-font,
      it.body
    )
    v(-1em)
    line(length: 100%)
    v(0.1em)
  }

  // 生成基础信息行
  let personal-infos = ()
  if telephone != "" {
    personal-infos.push([ #fa-phone-square() #h(0.3em) #telephone ])
  }
  if email != "" {
    personal-infos.push([ #fa-envelope() #h(0.5em) #link("mailto:" + email)[#email] ])
  }
  if github-id != "" {
    personal-infos.push({
      fa-github()
      h(0.6em)
      link("https://github.com/" + github-id, "github.com/" + github-id)
    })
  }
  if other-link != "" {
    personal-infos.push([ #fa-link() #h(0.5em)  #link(other-link, other-link) ])
  }
  if location != "" {
    personal-infos.push([ #fa-location-pin() #h(0.2em)  #location ])
  }
  if extra-info != "" {
    personal-infos.push(extra-info)
  }

  // 右上角图像
  if profile-image != "" {
    place(
      top + right,
      dx: -0.5em,
      image(
        profile-image, 
        height: 3em + 2.5em * element-spaciness, 
        width: auto, 
        fit: "contain")
    )
  }
  // 标题和基础信息
  block(
    height: auto,
    width: 100%,
    inset: 0.5em,
    // fill: luma(95%),
    {
      text(font: sans-serif-font, weight: 700, 2.0em, author)
      linebreak()
      v(0.5em * element-spaciness)
      personal-infos.join(" | ")
    }
  )
  
  body
}

#let resume-entry(
  title: "简历事项",
  subtitle: "",
  date: "",
  body
) = {
  // 条目首行
  strong(title)
  if subtitle != "" {
    set text(font: alt-serif-font)
    " | " + subtitle
  }
  if date != "" {
    set text(font: alt-serif-font)
    h(1fr)
    date
  }
  linebreak()

  // 条目详细内容
  v(-0.4em) // 取消段间距
  block(
    height: auto,
    width: 100%,
    inset: (right: 0.5em, y:0em),
    body
  )
}
