﻿using System;
using LuaInterface;
using SLua;
using System.Collections.Generic;
public class Lua_GameFrameworkMessage_Msg_CL_GmQueryUserByGuid : LuaObject {
	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static public int constructor(IntPtr l) {
		try {
			GameFrameworkMessage.Msg_CL_GmQueryUserByGuid o;
			o=new GameFrameworkMessage.Msg_CL_GmQueryUserByGuid();
			pushValue(l,true);
			pushValue(l,o);
			return 2;
		}
		catch(Exception e) {
			return error(l,e);
		}
	}
	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static public int get_m_QueryGuid(IntPtr l) {
		try {
			GameFrameworkMessage.Msg_CL_GmQueryUserByGuid self=(GameFrameworkMessage.Msg_CL_GmQueryUserByGuid)checkSelf(l);
			pushValue(l,true);
			pushValue(l,self.m_QueryGuid);
			return 2;
		}
		catch(Exception e) {
			return error(l,e);
		}
	}
	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static public int set_m_QueryGuid(IntPtr l) {
		try {
			GameFrameworkMessage.Msg_CL_GmQueryUserByGuid self=(GameFrameworkMessage.Msg_CL_GmQueryUserByGuid)checkSelf(l);
			System.UInt64 v;
			checkType(l,2,out v);
			self.m_QueryGuid=v;
			pushValue(l,true);
			return 1;
		}
		catch(Exception e) {
			return error(l,e);
		}
	}
	static public void reg(IntPtr l) {
		getTypeTable(l,"GameFrameworkMessage.Msg_CL_GmQueryUserByGuid");
		addMember(l,"m_QueryGuid",get_m_QueryGuid,set_m_QueryGuid,true);
		createTypeMetatable(l,constructor, typeof(GameFrameworkMessage.Msg_CL_GmQueryUserByGuid));
	}
}
