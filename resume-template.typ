#import "@preview/fontawesome:0.6.0": *

#let setup-styles(
  accent-color: rgb("#179299"),
  background-color: rgb("#e6e9e9"),
  sans-serif-font: "Source Han Sans SC",
  serif-font: "Source Han Serif SC", 
  alt-serif-font: "LXGW WenKai GB Screen",
  font-size: 11pt,
  element-spaciness: 1.00,
  separator: " | "
) = {
  
  let resume-header(
    author: "",
    profile-image: "",
    basic-info: (),
    telephone: "",
    email: "",
    github-id: "",
    other-link: "",
    location: "",
    body,
  ) = {
    set document(
      author: author, 
      title: author + "-个人简历", 
      date: datetime.today()
    )

    // 基础样式
    set page(
      margin: (x: 1.2cm * element-spaciness, y: 1.2cm * element-spaciness), // 页边距
      fill: background-color, // 页面背景色
    )
    set par(
      justify: true,
      leading: 0.5em * element-spaciness, // 行距
      spacing: 0.9em * element-spaciness, // 段间距
    )
    set text(
      font: ( // 修一下中文字体里的全角符号
        (name: "Times New Roman", covers: regex("•")),
        serif-font,
      ),
      lang: "zh",
      size: font-size,     // 全局字号
      ligatures: false
    )

    // 链接和强调样式
    show link: underline
    // show emph: underline
    show link: set text(fill: accent-color)
    show strong: set text(fill: accent-color)
    show emph: set text(weight: "black")

    // 小节标题样式 带横线
    show heading: it => {
      text(
        fill: accent-color,
        font: sans-serif-font,
        it.body
      )
      v(-1.0em)
      line(length: 100%, stroke: 
        (paint: luma(40%), thickness: 1.5pt, cap: "round"))
    }

    // 生成联系方式内容
    let contacts = ()
    if telephone != "" {
      contacts.push([ #fa-phone() #h(0.2em) #telephone ])
    }
    if email != "" {
      contacts.push([ #fa-envelope(solid: true) #h(0.3em) #link("mailto:" + email)[#email] ])
    }
    if github-id != "" {
      contacts.push({
        h(0.2em)
        fa-github()
        h(0.4em)
        link("https://github.com/" + github-id, "github.com/" + github-id)
      })
    }
    if other-link != "" {
      contacts.push([ #fa-link() #h(0.2em)  #link(other-link, other-link) ])
    }
    if location != "" {
      contacts.push([ #fa-location-dot() #h(0.2em) #location])
    }

    // 右上角图像
    if profile-image != "" {
      // 适应标题小节的高度
      let header-height = 3em + 2.1em * element-spaciness
      if basic-info.len() > 0 {
        header-height += 1em + 0.5em * element-spaciness
      }
      place(
        top + right,
        dx: -0.5em,
        image(
          profile-image, 
          height: header-height, 
          width: auto, 
          fit: "contain")
      )
    }
    // 标题和基础信息
    block(
      height: auto,
      width: 100%,
      inset: 0.5em,
      // fill: luma(70%),
      {
        text(font: sans-serif-font, weight: 700, 2.0em, author)
        linebreak()
        v(0.2em * element-spaciness)
        if basic-info.len() > 0 {
          basic-info.join(separator)
          linebreak()
        }
        contacts.join(separator)
      }
    )
    
    body
  }

  let resume-entry(
    title: "简历事项",
    subtitle: "",
    date: "",
    body
  ) = {
    // 条目首行
    strong(text(title, font: sans-serif-font))
    if subtitle != "" {
      text(font: alt-serif-font, separator + subtitle)
    }
    if date != "" {
      h(1fr)
      text(font: alt-serif-font, date)
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

  (
    resume-header: resume-header,
    resume-entry: resume-entry,
  )
}
