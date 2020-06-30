<template>
	<view>
		<view class="cu-list grid col-3 shadow-lg">
			<view class="cu-item">
				<view class="flex flex-sub flex-direction solid-right">
					<view class="text-df text-red text-bold" >
						实验室s
					</view>
					<view class="margin-top-sm text-grey text-sm">实验室</view>
				</view>
			</view>
			<view class="cu-item">
				<view class="flex flex-sub flex-direction solid-right">
					<view class="text-df text-blue text-bold">
						222
					</view>
					<view class="margin-top-sm text-grey text-sm">在线人数</view>
				</view>
			</view>
			<view class="cu-item">
				<view class="flex flex-sub flex-direction solid-right">
					<view class="text-df text-green text-bold">
						开放
					</view>
					<view class="margin-top-sm text-grey text-sm">状态</view>
				</view>
			</view>
		</view>
		
		<u-subsection :bold="true" :list="tabsList" :current="currentTab" @change="tabsChange"></u-subsection>
		</u-sticky>
		
		<!-- 日志 -->
		<block v-if="currentTabs == 0">
		<view class="cu-timeline " v-for="(item,index) in roomLogInfo" :key="index" >
			<view class="text-grey text-lg">{{item.ldate | dataFormat("YMD")}}({{item.ldate | duration()}})</view>
			<view class="cu-item " :class="item.status==1?'text-green':'text-blue'">
				<view class="shadow-blur content" :class="item.status==1?'bg-green':'bg-blue'">
					<view class="cu-capsule radius padd shadow-blur" v-if="item.during">
						<view class="cu-tag bg-black ">时长</view>
						<view class="cu-tag line-white">{{item.during | dataFormat("duration")}}</view>
					</view>
					<view class="cu-list menu-avatar radius">
						<view class="cu-item">
							<view class="cu-avatar radius lg" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}"></view>
							<view class="content">
								<view>
									<view class="text-bold text-xl text-black">{{item.user.realName}}</view>
									<view class="cu-tag radius sm " :class="item.status==1?'bg-green':'bg-blue'">{{item.status==1?'进':'出'}}</view>
								</view>
								<view class="text-gray text-sm flex">
									<view class="text-cut">{{item.status==1?'通过指纹进入':'通过指纹离开'}}</view>
								</view>
		
							</view>
							<view class="action">
								<view class="text-grey text-lg">{{item.ldate | dataFormat("Hm")}}</view>
								<view class="text-grey text-lg">星期{{item.ldate | dataFormat("E")}}</view>
							</view>
						</view>
		
					</view>
				</view>
			</view>
		</view>
		</block>
		
		<!-- 公告 -->
		<block v-else-if="currentTabs == 1">
		<view class="cu-card dynamic "  v-for="(item,index) in adminInfo " :key="index">
			<view class="cu-item shadow">
				<view class="cu-list menu-avatar">
					<view class="cu-item">
						<view class="cu-avatar radius xxl" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}"></view>
						<view class="content flex-sub text-xs">
							<view>{{item.user.realName}}</view>
							<view class="text-gray text-xs flex justify-between">
								{{item.ndate | dataFormat("YMDHm")}}
							</view>
						</view>
					</view>
				</view>
				<view class="padding-sm text-sm">
					{{item.notice}}
				</view>
				<view class="text-gray text-sm text-right padding-xs">
					<text class="cuIcon-attentionfill margin-lr-xs"></text>5人已读
				</view>
			</view>
		</view>
		<u-empty text="还没有公告" mode="message" v-if="!adminInfo[0]"></u-empty>
		
		</block>
		
		<!-- 成员 -->
		<block v-else-if="currentTabs == 2">
		<view class="padding-sm bg-white" >
			<u-cell-group>
					<u-cell-item  title="管理员列表"  :arrow="false">
						<u-icon slot="icon" size="33" name="setting"  ></u-icon>
					</u-cell-item>
				</u-cell-group>
				
				<!-- 管理员 -->
			<view class="cu-list grid col-6 no-border">
				<view class="cu-item padding-right-sm" v-for="(item,index) in memberInfo" :key="index">
					<block v-if="item.user.level==1">
						<view class="cu-avatar radius lg margin-sm " :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
							<view class="cu-tag badge radius">超管</view>
						</view>
						<text>{{item.user.realName}}</text>
					</block>
					<block v-else>
						<block v-if="item.isAdmin == 1">
							<view class="cu-avatar radius lg margin-sm " :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
								<view class="cu-tag badge radius">管</view>
							</view>
							<text>{{item.user.realName}}</text>
						</block>
					</block>
				</view>
				</view>
				
				<u-cell-group>
						<u-cell-item  title="已在实验室人员"  :arrow="false">
							<u-icon slot="icon" size="33" name="eye"  ></u-icon>
						</u-cell-item>
					</u-cell-group>
				
				<view class="cu-list grid col-6 no-border">
				<!-- 非管理员 -->
				<view class="cu-item padding-right-sm" v-for="(item,index) in memberInfo" :key="index" >
					<block v-if="item.status == 1">
						<view class="cu-avatar radius lg margin-sm" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
							<view class="cu-tag badge radius" v-if="item.user.level == 1">超管</view>
							<view class="cu-tag badge radius" v-else-if="item.isAdmin == 1" >管</view>
						</view>
						<text>{{item.user.realName}}</text>
					</block>
				</view>
			</view>
							
			<u-cell-group>
					<u-cell-item  title="不在实验室人员"  :arrow="false">
						<u-icon slot="icon" size="33" name="eye-off"  ></u-icon>
					</u-cell-item>
				</u-cell-group>
				
				<view class="cu-list grid col-6 no-border">
					<!-- 非管理员 -->
					<view class="cu-item padding-right-sm" v-for="(item,index) in memberInfo" :key="index" >
						<block v-if="item.status == 0">
							<view class="cu-avatar radius lg margin-sm grayscale" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
								<view class="cu-tag badge radius" v-if="item.user.level == 1">超管</view>
								<view class="cu-tag badge radius" v-else-if="item.isAdmin == 1" >管</view>
							</view>
							<text>{{item.user.realName}}</text>
						</block>
					</view>
				</view>
																							
			<u-divider>共{{memberInfo.length}}位成员</u-divider>
		</view>
		</block>
		
		<!-- 文件 -->
		<block v-else-if="currentTab == 3">
		<view class="cu-card dynamic "  >
			<view class="cu-item shadow">
				<view class="cu-list menu-avatar">
					<view class="cu-item">
						<view class="cu-avatar radius xxl" :style="{backgroundImage:'url('+wxuserInfo.avatarUrl+')'}"></view>
						<view class="content flex-sub text-xs">
							<view>{{wxuserInfo.nickName}}</view>
							<view class="text-gray text-xs flex justify-between">
								2020-06-15 12:05:20
							</view>
						</view>
					</view>
				</view>
				<view class="padding-sm text-sm">
					{{roomDetailInfo}}注意事项.txt
				</view>
				<view class="text-gray text-sm text-right padding-xs">
					<text class="cuIcon-attentionfill margin-lr-xs"></text>5人已读
				</view>
			</view>
		</view>
		</block>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			
		}
	}
</script>

<style>

</style>
