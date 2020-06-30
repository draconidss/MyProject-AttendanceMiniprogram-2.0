### 数字LED时间屏显

> 组件说明：组件目前只有四个模式，我把基础的内容做好了，可以自由扩展其他

### 属性说明

1. `mode [number]` 显示模式 ： 1. 时间模式 ： 正常模式 : 显示十、分、秒 2. 时间模式 ： 不显示秒 3. 时间记录模式 4. 自定义模式 ，随意输入
 
2. `close [boolean]` 时间模式中，是否开启间隔符号
 
3. `twinkle [boolean]` 间隔符号开启状态下，间隔符号是否闪烁
 
4. `valArr [Array]` 自定义模式下，输入的数组

### 事件说明

暂无事件 ，目前只是显示组件，不涉及到事件回调


### 注意事项
1. 在自定义模式下 ，数据格式要严格按照我规定的来。  
数组中每个索引中 只能是数字0-9或者符号‘：’ 。其他一概不识别。 

```javascipt
this.valArr = [1 ,2 ,':' ,0 ,1 ,':' ,0 ,0]
// 以上格式 输出 12:01:00 

this.valArr = [1 ,2 ,3 ,4]
// 以上格式 输出1234

```

2. 如果需要做倒计时，可以自己写业务逻辑 ，直接按照数据格式 ，直接传值给组件即可



### 调用方式

```javascipt
<template>
	<view class="content">
		<!-- <calendar :selected="selected" @getdate="getdate" /> -->
		1. 时间显示模式：正常显示时间
		<led :mode="1"></led>
		2. 时间显示模式：不显示秒
		<led :mode="2"></led>
		3. 计时器模式
		<led :mode="3"></led>
		4. 自定义模式
		<led :mode="4" :val-arr="arr"></led>
	</view>
</template>

<script>
import led from '../../components/mehaotian-numled/mehaotian-numled.vue';
export default {
	components: {
		led
	},
	data() {
		return {
			arr: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
		};
	},
	onLoad() {
		setTimeout(() => {
			this.arr = [0, 9, 8, 7, 6, 5, 4, 3, 2, 1];
		}, 2000);
	}
};
</script>

<style lang="scss" scoped>
.content {
	padding: 50upx;
}
</style>

```