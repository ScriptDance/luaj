package com.android;

import android.app.Activity;
import android.os.Bundle;
import com.androlua.R;
import com.luajava.LuaState;
import com.luajava.LuaStateFactory;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        LuaState luaState = LuaStateFactory.newLuaState();

        luaState.openBase();

        luaState.LdoString("print('123')");


    }
}