package com.androlua;

import android.widget.*;
import android.content.*;
import android.view.*;
import com.luajava.*;

public class LuaArrayAdapter extends ArrayAdapter
{

	private Main mContext;

	private String[] mObjects;
	
	private LuaState L;

	private LuaObject mFields;
	public LuaArrayAdapter(Main context,LuaObject fields,String[] objects)
	{
		super(context,0,objects);
		mFields=fields;
		mContext=context;
		mObjects=objects;
		L=mContext.getLuaState();
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent)
	{
		// TODO: Implement this method
		TextView tv;
		if (convertView==null)
		{
			tv=new TextView(mContext);
			L.pushJavaObject(tv);
			mFields.push();
			L.pushNil();
			while(L.next(-2)!=0)
			{
				String filed=L.toString(-2);
				L.setField(-4, filed);
			}
		}
		else
			tv=(TextView)convertView;
		tv.setText(mObjects[position]);
		return tv;
	}
	
	
}
