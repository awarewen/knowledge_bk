# RFC
---
> 以下摘抄自
>> [百度百科#RFC](https://baike.baidu.com/item/RFC/1840?fr=aladdin)

[Request For Comments(RFC)](http://www.faqs.org/rfcs/)，是一系列以编号排列的文件文档。其中收集了有关互联网的标准或非标准的相关技术信息。由`Internet Society(ISOC)`赞助发行。基本的互联网通信协议都在RFC文档内有详细的说明。几乎所有互联网标准都有收集在RFC文档中。

> 一份RFC文档必须被分配 **RFC `ID(Internet Drafts)编号`** 才能进行出版，在发布后是不会再对这个文档进行修改的，只能在新的RFC文档版本中对上一个版本内容进行修订。

---
## 重要性
RFC (Request For Comments)意即“请求评论”，其中包含了关于Internet的几乎所有重要的文字资料。当某家机构或团体开发出一套标准或提出某种标准的设想，想征询外界的意见时，就会在Internet上发放一份RFC，对这一问题感兴趣的人可以阅读该RFC并提出自己的意见。

绝大部分网络标准的制定都是以RFC的形式开始，经过大量的论证和修改，最后由主要的标准化组织所指定。

但并不是所有的RFC文档都是正在被使用的或被大家公认的，也有很大一部分只是在某个局部领域或被使用或并没有被采用，一份RFC具体处于什么状态都在文件中做了明确的标识。

---
## RFC 文档
RFC 由一系列草案组成，起始于1969年（第一个RFC文档发布与1969年4月7日，参见 RFC30年|[RFC2555](https://www.rfc-editor.org/info/rfc2555)）。"[RFC Editor](https://www.rfc-editor.org/)"是RFC文档的出版者，负责RFC最终文档的编辑审订以及RFC整体的结构文档，`RFC Editor`也保留有RFC的主文件，称为RFC索引，用户可以在线检索，索引由`RFC Editor`维护。

RFC面向所有人，文档使用的语言为英语，*"[RFC 2026](https://www.rfc-editor.org/info/rfc2026): `"The Internet Standards Process -- Revision 3"` 允许RFC翻译成其他不同的语言，但并不保证翻译版本的完全正确，"RFC Editor"不对非英语的版本负责，而只是在WEB页面中指明哪里有非英语的版本*。

RFC文档讨论的内容涵盖了计算机网络的方方面面，重点在**网络协议，进程，程序，概念以及一些会议纪要，意见，各种观点等**。

---
## RFC 审计流程
一个RFC文件在成为标准前一般至少要经过4个阶段：**Internet草案、建议标准、草案标准、Internet标准**。

 > 关于RFC文档编写的注意事项和RFC的Internet标准须知的RFC文档
> [RFC 2026](https://www.rfc-editor.org/info/rfc2026)
> [RFC 2223](https://www.rfc-editor.org/info/rfc2223)

##### 起草阶段
 第一步RFC出版是作为一个Internet草案发布，可以阅读并对其进行注释。准备一个RFC草案要求作者先阅读`IETF`的一个文档`"Considerations for Internet Drafts"`，这个文档包含了关于RFC以及Internet草案格式的有用信息。作者还应该阅读另一个相关文档 [RFC 2223](https://www.rfc-editor.org/info/rfc2223):`"Instructions to Authors"`
 > 起草期间需要进行的一些必要准备，阅读相关起草文档以及核对文章信息，完整无误后提交文档获取**`Internet Drafts(ID)`**编号。

##### 建议标准阶段
 一旦文档拥有一个`(Internet Drafts)ID`编号后，作者如果觉得这个文档不错可以向`rfc-editor@rfc-editor.org`发送E-mail，表达此文档能够作为一个有价值或有经验的RFC文档。`RFC Editor`将会向`IESG`请求查阅该文档并给其加上评论和注释。一旦文档获得通过，`RFC Editor`就会将其编辑并出版。*如果文档没有通过，不能出版，则会有一份`E-mail`通知作者不能出版的原因，作者有`48`小时的时间来校对RFC文档。一旦RFC文档出版后就无法做出更改了*。
 > 由`RFC Editor`向`IESG`请求查阅文档并加上评论和注释，通过审核后`RFC Editor`将文档编辑出版为建议标准。
 
##### 草案标准阶段
草案存放在美国、欧洲和亚太地区的工作文件站上，供世界多国自愿参加的`IETF`成员进行讨论，测试和审查。由`Internet工程指导组(IESG)`确定该草案能否成为Internet标准。*如果一个Internet草案在`IETF`的相关站点上存在6个月后仍未被`IESG`建议作为标准发布，它则会被从所在站点删除。事实上，在任何时刻，一个Internet草案都可能被新的草案版本替换掉，并重新开始计算6个月的存放期限*。
> `IETF`成员将会对`RFC Editor`出版的建议标准进行讨论、测试和审查，以6个月为期限建议出版或者删除此文档，6个月期间文档可以被新的草案替换并重新计算期限。

##### Internet标准阶段
如果一个Internet草案被 `IESG`确定为Internet的正式工作文件，则会被提交到`Internet 体系结构委员会(IAB)`，并形成具有顺序编号的RFC文档，由`Internet协会(ISOC)`向全世界发布。*每个Internet标准文件被批准后都会分配一个`独立于RFC的永久编号(STD)`，有一个不断被更新的文件`RFC-INDEX.TXT`按照RFC的编号来索引所有的文件*。

##### 标准RFC文档的不同形式
标准的RFC文档可以有几种不同的形式：
	1. 提议性的标准：作为一个建议性的提案，草案可能已经被部分人采用了，希望能成为正式的标准，建议所有人都能参照此标准。
	2. 已践行的标准：已经被大家完全采用的方案，而且是不应该改变的。
	3. 最佳实践标准：推举一种方法作为某种技术的最佳实践方案。

## RFC文档的统一标准
RFC 出版的文件只有新增，不会有取消或突然停止发行的情况，对于同一主题可以通过新的RFC文件取代旧的文件。

