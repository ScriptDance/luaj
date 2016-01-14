package com.androlua;

import android.os.*;
import com.luajava.*;
import java.io.*;
import android.view.Window.*;

public class LuaAsyncTask extends AsyncTask
{

	private LuaState L;
	
	private StringBuilder output = new StringBuilder();
	
	private Main mMain;

	private String luaDir;

	private byte[] mBuffer;

	private LuaObject mCallback;

	private String luaCpath;

	private LuaObject mUpdate;

	public LuaAsyncTask(Main main,String src,LuaObject callback) throws LuaException
	{
		mMain=main;
		luaDir=main.luaDir;
		luaCpath=mMain.luaCpath;
		mBuffer=src.getBytes();
		mCallback=callback;
	}
	
	
	public LuaAsyncTask(Main main,LuaObject func,LuaObject callback) throws LuaException
	{
		mMain=main;
		luaDir=main.luaDir;
		luaCpath=mMain.luaCpath;
		mBuffer=func.dump();
		mCallback=callback;
	}

	public LuaAsyncTask(Main main,LuaObject func,LuaObject update,LuaObject callback) throws LuaException
	{
		mMain=main;
		luaDir=main.luaDir;
		luaCpath=mMain.luaCpath;
		mBuffer=func.dump();
		mUpdate=update;
		mCallback=callback;
	}
	
	/*public void execute(Object[] params) throws IllegalArgumentException, ArrayIndexOutOfBoundsException, LuaException
	{
		// TODO: Implement this method
		super.execute(params);
	}
	*/
	public void execute() throws IllegalArgumentException, ArrayIndexOutOfBoundsException, LuaException
	{
		// TODO: Implement this method
		super.execute();
	}
	
	public void update(Object msg)
	{
		publishProgress(msg);
	}
	
	public void update(String msg)
	{
		publishProgress(msg);
	}
	
	public void update(int msg)
	{
		publishProgress(msg);
	}
	
	@Override
	protected Object doInBackground(Object[] args) 
	{
		L = LuaStateFactory.newLuaState();
		L.openLibs();
		L.pushJavaObject(mMain);
		L.setGlobal("activity");
		L.pushJavaObject(this);
		L.setGlobal("this");
		
		L.getGlobal("luajava");
		L.pushString(luaDir);
		L.setField(-2, "luadir"); 
		L.pop(1);

		try
		{
			JavaFunction print = new LuaPrint(mMain,L);
			print.register("print");

			JavaFunction update = new JavaFunction(L){

				@Override
				public int execute() throws LuaException
				{
					// TODO: Implement this method
					update(L.toJavaObject(2));
					return 0;
				}
			};
			
			update.register("update");
			
			JavaFunction assetLoader = new LuaAssetLoader(mMain,L); 

			L.getGlobal("package");  
			L.getField(-1, "loaders");
			int nLoaders = L.objLen(-1);
			int idx=3;
			if(mMain.isInAsset())
				idx=2;
			for (int i=nLoaders;i >= idx;i--)
			{
				L.rawGetI(-1, i);
				L.rawSetI(-2, i + 1);
			}
			L.pushJavaFunction(assetLoader); 
			L.rawSetI(-2, idx);
			L.pop(1);          
			
			L.pushString("./?.lua;" + luaDir + "/?.lua;" + luaDir + "/lua/?.lua;" + luaDir + "/?/init.lua;");
			L.setField(-2, "path");
			L.pushString(luaCpath);
			L.setField(-2, "cpath");
			L.pop(1); 
		}
		catch (LuaException e)
		{
			mMain.sendMsg(e.getMessage());
		}
		try
		{
			L.setTop(0);
			int ok = L.LloadBuffer(mBuffer,"LuaAsyncTask");

			if (ok == 0)
			{
				L.getGlobal("debug");
				L.getField(-1, "traceback");
				L.remove(-2);
				L.insert(-2);
				int l=args.length;
				for (int i=0;i < l;i++)
				{
					L.pushObjectValue(args[i]);
				}
				ok = L.pcall(l, LuaState.LUA_MULTRET, -2 - l);
				if (ok == 0)
				{
					int n=L.getTop()-1;
					Object[] ret=new Object[n];
					for(int i=0;i<n;i++)
						ret[i]=L.toJavaObject(i+2);
					return ret;
				}
			}
			throw new LuaException(errorReason(ok) + ": " + L.toString(-1));
		} 
		catch (LuaException e)
		{			
			mMain.sendMsg(e.getMessage());
		}


		return null;
	}

	@Override
	protected void onPostExecute(Object result)
	{
		// TODO: Implement this method

		try
		{
			if(mCallback!=null)
				mCallback.call((Object[])result);
		}
		catch (LuaException e)
		{
			mMain.sendMsg(e.getMessage());
		}
		super.onPostExecute(result);
		L.gc(LuaState.LUA_GCCOLLECT, 1);
		System.gc();
		//L.close();
	}
	
	@Override
	protected void onProgressUpdate(Object[] values)
	{
		// TODO: Implement this method
		try
		{
			if (mUpdate != null)
				mUpdate.call(values);
		}
		catch (LuaException e)
		{
			mMain.sendMsg(e.getMessage());
		}
		super.onProgressUpdate(values);
	}
	
	private String errorReason(int error)
	{
		switch (error)
		{
			case 6:
				return "error error";
			case 5:
				return "GC error";
			case 4:
				return "Out of memory";
			case 3:
				return "Syntax error";
			case 2:
				return "Runtime error";
			case 1:
				return "Yield error";
		}
		return "Unknown error " + error;
	}
	
}

