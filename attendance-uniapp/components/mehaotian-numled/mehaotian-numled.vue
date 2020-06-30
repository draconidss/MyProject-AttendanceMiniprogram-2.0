<template>
	<view class="wrap">
		<view class="box" 
			:class="{'circle':item === ':','clear':item === ':'&&!close,'active':item === ':'&&twinkle}" 
			v-for="(item,index) in list" 
			:key="index">
			<block v-if="item === ':'">
				<view v-if="close" class="circle-box "></view>
				<view v-if="close" class="circle-box "></view>
			</block>
			<block v-else>
				<view :class="{'box-top':idx === 0 , 'box-bottom':idx === 1 }" v-for="(num , idx) in 2" :key="idx">
					<view v-if="idx === 0" class="box-top-top" :class="{'active':timeList[item][0]}"></view>
					<view class="box-top-right" :class="{'active':timeList[item][idx===0 ?1:4]}"></view>
					<view class="box-top-bottom" :class="{'active':timeList[item][idx===0 ?2:5]}"></view>
					<view class="box-top-left " :class="{'active':timeList[item][idx===0 ?3:6]}"></view>
				</view>
			</block>
		</view>
	</view>
</template>

<script>
export default {
	props: {
		/**
		 * 模式
		 * 1. 时间模式 ： 正常模式 : 显示十、分、秒
		 * 2. 时间模式 ： 不显示秒
		 * 3. 时间记录模式
		 * 4. 自定义模式 ，随意输入数字数组
		 */
		mode: {
			type: Number,
			default: 1
		},
		startTime:{
			type: Array,
			default: [0, 0, ':', 0, 0, ':', 0, 0]
		},
		/**
		 * 是否开启间隔符号
		 */
		close: {
			type: Boolean,
			default: true
		},
		/**
		 * 间隔符号是否闪烁
		 */
		twinkle: {
			type: Boolean,
			default: false
		},
		valArr:{
			type: Array,
			default: ()=>{
				return []
			}
		},
		
	},
	data() {
		return {
			// 定义时间显示规律
			timeList: {
				'1': [false, true, false, false, true, false, false],
				'2': [true, true, true, false, false, true, true],
				'3': [true, true, true, false, true, true, false],
				'4': [false, true, true, true, true, false, false],
				'5': [true, false, true, true, true, true, false],
				'6': [true, false, true, true, true, true, true],
				'7': [true, true, false, false, true, false, false],
				'8': [true, true, true, true, true, true, true],
				'9': [true, true, true, true, true, true, false],
				'0': [true, true, false, true, true, true, true]
			},
			list: [], // 显示时间
			timer: null
		};
	},
	created() {
		// 显示模式1 初始化
		if (this.mode < 3) {
			clearInterval(this.timer);
			this.list = this.strToArr(this.Format(new Date()), this.mode);
			this.timer = setInterval(() => {
				this.list = this.strToArr(this.Format(new Date()), this.mode);
			}, 1000);
		}
		if (this.mode === 3) {
			this.timeMeter();
		}
		if(this.mode === 4){
			this.list = this.valArr
		}
	},
	watch:{
		valArr(newVal,oldVal){
			console.log(newVal)
			this.list = newVal
		}
	},
	methods: {
		/**
		 * 计时器
		 */
		timeMeter() {
			this.list = this.startTime
			let num = this.list[7];
			clearInterval(this.timer);
			this.timer = setInterval(() => {
				num++;
				// 倒计时
				if (num > 9) {
					this.$set(this.list, 7, 0);
					num = this.list[6];
					num++;
					this.$set(this.list, 6, num);
					if (num > 5) {
						this.$set(this.list, 6, 0);
						num = this.list[4];
						num++;
						this.$set(this.list, 4, num);
						if (num > 9) {
							this.$set(this.list, 4, 0);
							num = this.list[3];
							num++;
							this.$set(this.list, 3, num);
							if (num > 5) {
								this.$set(this.list, 3, 0);
								num = this.list[1];
								num++;
								this.$set(this.list, 1, num);
								if (num > 9) {
									this.$set(this.list, 1, 0);
									num = this.list[0];
									num++;
									this.$set(this.list, 0, num);
									if (num > 5) {
										this.$set(this.list, 0, 0);
										// 如果时间到底，不循环就打开这段代码
										// clearInterval(this.timer);
									}
								}
							}
						}
					}
					num = 0;
				}
				this.$set(this.list, 7, num);
			}, 1000);
		},

		/**
		 * 时间格式化
		 */
		Format(fmt) {
			let date = new Date(fmt);
			var o = {
				h: date.getHours(), //小时
				m: date.getMinutes(), //分
				s: date.getSeconds() //秒
			};
			// console.log(o.h, o.m, o.s);
			return (
				(o.h < 10 ? '0' + o.h : o.h) +
				':' +
				(o.m < 10 ? '0' + o.m : o.m) +
				':' +
				(o.s < 10 ? '0' + o.s : o.s)
			);
		},
		/**
		 * 字符串转数组
		 */
		strToArr(str, num) {
			if (num === 1) {
				return str.split('');
			}
			if (num === 2) {
				return [
					str.split('')[0],
					str.split('')[1],
					str.split('')[2],
					str.split('')[3],
					str.split('')[4]
				];
			}
		}
	}
};
</script>

<style lang="scss" scoped>
@import './mehaotian-numled.scss';

.wrap {
	display: flex;
	align-items: center;
	width: 100%;
	box-sizing: border-box;
	.content-box {
		display: flex;
		align-items: center;
		width: 100%;
		box-sizing: border-box;
	}
	.box {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 100%;
		margin: 2%;
		box-sizing: border-box;
		&.circle {
			width: 20%;

			.circle-box {
				width: 100%;
				height: 0;
				padding-top: 100%;
				background: #fff;
				&:last-child {
					margin-top: 200%;
				}
			}
			&.active {
				opacity: 0.05;
				animation: twinkle 1s infinite;
			}
			@keyframes twinkle {
				0%,
				100% {
					opacity: 0;
				}
				50% {
					opacity: 1;
				}
			}
		}
		&.clear {
			display: none;
		}
		.box-top,
		.box-bottom {
			position: relative;
			width: 100%;
			height: 0;
			padding-top: 100%;
			&.box-top {
				.box-top-top {
					top: 0;
					left: 0;
					width: 100%;
					height: $border-width;
					@include diffstyle($imgtTansverse);
				}
				.box-top-right {
					top: 0;
					right: 0;
					width: $border-width;
					height: 100%;
					@include diffstyle($imgVertical);
				}
				.box-top-bottom {
					bottom: 0;
					height: $border-width;
					width: 100%;
					@include diffstyle($imgtTansverse);
				}
				.box-top-left {
					top: 0;
					left: 0;
					width: $border-width;
					height: 100%;
					@include diffstyle($imgVertical);
				}
			}
			&.box-bottom {
				margin-top: -$border-width;
				.box-top-right {
					top: 0;
					right: 0;
					width: $border-width;
					height: 100%;
					@include diffstyle($imgVertical);
				}
				.box-top-bottom {
					bottom: 0;
					height: $border-width;
					width: 100%;
					@include diffstyle($imgtTansverse);
				}
				.box-top-left {
					top: 0;
					left: 0;
					width: $border-width;
					height: 100%;
					@include diffstyle($imgVertical);
				}
			}
		}
	}
}
</style>
