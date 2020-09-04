# Comic_Flutter

获取U17(有妖气)漫画API接口，制作一个漫画APP

### APK下载地址
[蓝奏云](https://wws.lanzous.com/b01hlvv6d)
密码：1234

###  环境

Flutter 1.17.5

MacOS

###  第三方插件

<img src="https://jackieli.oss-cn-shenzhen.aliyuncs.com/%E6%88%AA%E5%B1%8F2020-08-17%20%E4%B8%8A%E5%8D%885.11.18.png" width="400"/>

###  效果图

<div style="text-align: center">
  <table>
    <tr>
      <td style="text-align: center">
        <img src="https://jackieli.oss-cn-shenzhen.aliyuncs.com/Screenshot_2020-08-17-05-23-42-993_com.jackieli.c.jpg" width="200"/>
      </td>
      <td style="text-align: center">
        <img src="https://jackieli.oss-cn-shenzhen.aliyuncs.com/Screenshot_2020-08-17-05-24-13-961_com.jackieli.c.jpg" width="200"/>
      </td>
      <td style="text-align: center">
        <img src="https://jackieli.oss-cn-shenzhen.aliyuncs.com/Screenshot_2020-08-17-05-24-24-234_com.jackieli.c.jpg" width="200"/>
      </td>
      <td style="text-align: center">
        <img src="https://jackieli.oss-cn-shenzhen.aliyuncs.com/Screenshot_2020-08-17-05-24-43-075_com.jackieli.c.jpg" width="200"/>
      </td>
    </tr>
  </table>
</div>

###  目前功能

- [x] 漫画搜索
- [x] 漫画关注
- [x] 观看漫画
- [ ] 观看历史
- [ ] 漫画作者页


####  国际惯例
- 本项目只做个人学习研究之用，不得用于商业用途！
####  API接口
- 请求地址
  ```
  https://app.u17.com/v3/appV3_3/android/phone
  ```
  
- 获取漫画列表
  ```
  /list/conditionScreenlists
  ```
  可选参数
  - page(默认为1)
  - v(这个参数不传拿的不是全部漫画)
  请求示例
  ```
  https://app.u17.com/v3/appV3_3/android/phone/list/conditionScreenlists?v=5300100&page=1
  ```
  
- 获取漫画详情
  ```
  /comic/detail_static_new 
  ```
  参数
  - comicid
  请求示例
  ```
  https://app.u17.com/v3/appV3_3/android/phone/comic/detail_static_new?comicid=8805
  ```
- 获取漫画图片
  ```
  /comic/chapterNew
  ```
  参数
  - chapter_id(章节id)
  请求示例
  ```
  https://app.u17.com/v3/appV3_3/android/phone/comic/chapterNew?chapter_id=31066
  ```
- 漫画搜索
  ```
  /search/relative
  ```
  参数
  - inputText
  请求示例
  ```
  https://app.u17.com/v3/appV3_3/android/phone/search/relative?inputText=%E9%95%87%E9%AD%82%E8%A1%97
  ```
####  如果对你有帮助请点个Star吧！谢谢！
