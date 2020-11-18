### Jectivator 
#### JetBrians系列产品一键激活脚本
> 最近市面上的激活工具都被封杀的差不多了，懒得找了所以自己做了一个一键激活脚本，不用改hosts，不用改vmoptions，甚至不用填激活码，还蛮方便的。

> 激活文件采集自medeming.com

### 支持的产品：
+ IntelliJIdea  
+ WebStorm
+ PhpStorm  
+ PyCharm
+ DataGrip  
+ CLion     
+ GoLand        

### 支持的系统：
    具有标准Bash环境的GNU/Linux

### 使用方法：
注意：不要改hosts，以前改过的请改回来!
1. 从Jetbrains官网下载的产品解压之后，移动到你想存放的位置。
2. 先运行一遍，到激活界面就可以了，不需要点试用，运行之后不要随意挪动Jetbrians产品的位置。
3. 给脚本执行权限后运行，等脚本自动执行完就行了。

``` shell 
    chmod +x jectivator.sh;./jectivator.sh
    # 或者使用bash终端直接运行
    /bin/bash jectivator.sh
```
4. 激活完了之后，你想怎么挪动Jetbrians产品都可以