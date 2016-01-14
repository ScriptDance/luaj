require "import"
import "console"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "java.io.*"
import "android.text.method.*"
require "layout"
activity.setTitle('AndroLua+')
activity.setTheme(android.R.style.Theme_Holo_Light)
--activity. getActionBar().show()
luadir=luajava.luaextdir.."/" or "/sdcard/androlua/"
luaconf=luajava.luadir.."/lua.conf"
pcall(dofile,luaconf)
luapath=luapath or luadir.."new.lua"
luadir=luapath:match("^(.-)[^/]+$")
activity.getActionBar().setDisplayShowHomeEnabled(false)

code=[===[
require "import"
import "android.widget.*"
import "android.view.*"

]===]
pcode=[[
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
require "layout"
activity.setTitle('AndroLua+')
activity.setTheme(android.R.style.Theme_Holo_Light)
activity.setContentView(loadlayout(layout.main))
]]


lcode=[[
layout={
  main={
    LinearLayout,
    orientation="vertical",
    {
      TextView,
      text="hello AndroLua+",
      layout_width="fill"
    },
  },
}
]]
upcode=[[
user_permission={
  "INTERNET",
  "WRITE_EXTERNAL_STORAGE",
}
]]
about=[[
AndroLua是基于LuaJava开发的安卓平台轻量级脚本编程语言工具，既具有Lua简洁优雅的特质，又支持绝大部分安卓API，可以使你在手机上快速编写小型应用。
官方QQ群：236938279
http://jq.qq.com/?_wv=1027&k=dcofRr
百度贴吧：
http://c.tieba.baidu.com/mo/m?kw=androlua
项目地址：
http://sf.net/p/androlua
点击链接支持我的工作，一块也可以哦：
https://qr.alipay.com/apt7ujjb4jngmu3z9a
]]


local BitmapDrawable=luajava.bindClass("android.graphics.drawable.BitmapDrawable")
m={
  {MenuItem,
    title="运行",
    id="play",
    icon="play",},
  {MenuItem,
    title="撤销",
    id="undo",
    icon="undo",},
  {MenuItem,
    title="重做",
    id="redo",
    icon="redo",},
  {SubMenu,
    title="文件...",
    {MenuItem,
      title="打开",
      id="file_open",},
    {MenuItem,
      title="保存",
      id="file_save",},
    {MenuItem,
      title="新建",
      id="file_new",},
    {MenuItem,
      title="编译",
      id="file_build",},
  },
  {SubMenu,
    title="工程...",
    {MenuItem,
      title="打开",
      id="project_open",},
    {MenuItem,
      title="打包",
      id="project_build",},
    {MenuItem,
      title="新建",
      id="project_create",},
  },
  {SubMenu,
    title="代码...",
    {MenuItem,
      title="格式化",
      id="code_format",},
    {MenuItem,
      title="查错",
      id="code_check",},
  },
  {SubMenu,
    title="转到...",
    {MenuItem,
      title="搜索",
      id="goto_seach",},
    {MenuItem,
      title="转到",
      id="goto_line",},
    {MenuItem,
      title="导航",
      id="goto_func",},
  },
  {SubMenu,
    title="更多...",
    {MenuItem,
      title="日志",
      id="more_logcat",},
    {MenuItem,
      title="帮助",
      id="more_help",},
    {MenuItem,
      title="手册",
      id="more_manual",},
  }
}
optmenu={}
items={"运行","撤销","重做","打开","保存","新建","新建工程", "格式化","查错","导航","转到","搜索","编译","打包","日志","帮助","手册",}
function onCreateOptionsMenu(menu)
  loadmenu(menu,m,optmenu)
end

function switch(s)
  return function(t)
    local f=t[s]
    if not f then
      for k,v in pairs(t) do
        if s.equals(k) then
          f=v
          break
        end
      end
    end
    f=f or t.default
    return f and f()
  end
end

function donothing()
  print("功能开发中")
end



luaprojectdir=luajava.luaextdir.."/project/"
function create_project()
  local appname=project_appName.getText().toString()
  local packagename=project_packageName.getText().toString()
  local f=File(luaprojectdir..appname)
  if f.exists() then
    print("工程已存在")
    return
  end
  if not f.mkdirs() then
    print("工程创建失败")
    return
  end
  luadir=luaprojectdir..appname.."/"
  write(luadir.."init.lua",string.format("appname=\"%s\"\nappver=\"1.0\"\npackagename=\"%s\"\n%s",appname,packagename,upcode))
  write(luadir.."main.lua",pcode)
  write(luadir.."layout.lua",lcode)
  project_dlg.hide()
  luapath=luadir.."main.lua"
  read(luapath)
end

function update(s)
  bin_dlg.setMessage(s)
end

function callback(s)
  if s:find("成功") then
    bin_dlg.hide()
  end
end
function read(path)
  local f=io.open(path,"r")
  editor.setText(f:read("*all"))
  f:close()
  activity.getActionBar().setSubtitle(".."..path:match("(/[^/]+/[^/]+)$"))
  local p={}
  local e=pcall(loadfile(luadir.."init.lua","bt",p))
  if e then
    activity.setTitle(p.appname)
  else
    activity.setTitle("AndroLua+")
  end
  luapath=path
  write(luaconf,string.format("luapath=%q",path))
  --Toast.makeText(activity, "打开文件."..path, Toast.LENGTH_SHORT ).show()
end

function write(path,str)
  local sw=io.open(path,"wb")
  sw:write(str)
  sw:close()
  return str
end

function save()
  local src=editor.getText().toString()
  write(luapath,src)
  return src
end

function click(s)
  func[s.getText()]()
end

function create()
  luapath=luadir.. create_e.getText().toString()
  if not pcall(read,luapath) then
    f=io.open(luapath,"a")
    f:write(code)
    f:close()
    editor.setText(code)
    write(luaconf,string.format("luapath=%q",luapath))
    Toast.makeText(activity, "新建文件."..luapath, Toast.LENGTH_SHORT ).show()
  else
    Toast.makeText(activity, "打开文件."..luapath, Toast.LENGTH_SHORT ).show()
  end
  write(luaconf,string.format("luapath=%q",luapath))
  activity.getActionBar().setSubtitle(".."..luapath:match("(/[^/]+/[^/]+)$"))
  create_dlg.hide()
end

function open(s)
  local p= s.getText()
  if p== luadir then
    return nil
  end
  if p:find("%.%./") then
    luadir=luadir:match("(.-)[^/]+/$")
    list(listview, luadir)
  elseif p:find("/") then
    luadir=luadir..p
    list(listview, luadir)
  else
    luapath=luadir..p
    read(luapath)
    Toast.makeText(activity, "打开文件."..luapath, Toast.LENGTH_SHORT ).show()
    open_dlg.hide()
  end
end

function list(v,p)
  local f=File(p)
  local fs=f.listFiles()
  fs=fs or String[0]
  Arrays.sort(fs)
  local t={}
  if p~="/" then
    table.insert(t,"../")
  end
  for n=0,#fs-1 do
    if fs[n].isDirectory() then
      table.insert(t,fs[n].getName().."/")
    end
  end
  for n=0,#fs-1 do
    local name=fs[n].getName()
    if fs[n].isFile() and name:find("lua$") then
      table.insert(t,name)
    end
  end
  open_title.setText(p)
  local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(t))
  v.setAdapter(adapter)
end

bin=function(luapath,appname,appver,packagename,apkpath)
  require "import"
  import "console"

  import "java.util.zip.*"
  import "java.io.*"
  import "mao.res.*"
  import "apksigner.*"
  function copy(input,output)
    local b=byte[2^16]
    local l=input.read(b)
    while l>1 do
      output.write(b,0,l)
      l=input.read(b)
    end
  end


  local tmp=luajava.luadir.."/tmp.apk"
  local info=activity.getApplicationInfo()
  local ver=activity.getPackageManager().getPackageInfo(activity.getPackageName(),0).versionName

  local zip=ZipFile(info.publicSourceDir)
  local out=ZipOutputStream(FileOutputStream(tmp))
  local entries= zip.entries()
  local f=File(luapath)
  local errbuffer={}
  local replace={
    ["lib/armeabi/libalog.so"]=true,
    ["lib/armeabi/libbson.so"]=true,
    ["lib/armeabi/libcanvas.so"]=true,
    ["lib/armeabi/libcjson.so"]=true,
    ["lib/armeabi/libgl.so"]=true,
    ["lib/armeabi/libcrypt.so"]=true,
    ["lib/armeabi/libjni.so"]=true,
    ["lib/armeabi/libmd5.so"]=true,
    ["lib/armeabi/libluv.so"]=true,
    ["lib/armeabi/libregex.so"]=true,
    ["lib/armeabi/libsensor.so"]=true,
    ["lib/armeabi/libxml.so"]=true,
    ["lib/armeabi/libtcc.so"]=true,
    ["lib/armeabi/libzlib.so"]=true,
    ["lib/armeabi/libzip.so"]=true,
  }

  function checklib(path)
    local f=io.open(path)
    local s=f:read("*a")
    f:close()
    for m in s:gmatch("require *\"([%w_]+)") do
      replace[string.format("lib/armeabi/lib%s.so",m)]=nil
    end
    for m in s:gmatch("import *\"([%w_]+)") do
      replace[string.format("lib/armeabi/lib%s.so",m)]=nil
    end
  end


  local mainpath


  function addDir(out,dir,f)
    local ls=f.listFiles()
    for n=0,#ls-1 do
      local name=ls[n].getName()
      if name:find("%.lua$") then
        checklib(luapath..dir..name)
        local path,err=console.build(luapath..dir..name)
        if path then
          entry=ZipEntry("assets/"..dir..name)
          out.putNextEntry(entry)
          replace["assets/"..dir..name]=true
          copy(FileInputStream(File(path)),out)
        else
          table.insert(errbuffer,err)
        end
      elseif ls[n].isDirectory() then
        addDir(out,dir..name.."/",ls[n])
      elseif ls[n].isFile() and (not ((name:find("%.luac$")) or (name:find("%.apk$")))) then
        entry=ZipEntry("assets/"..dir..name)
        out.putNextEntry(entry)
        replace["assets/"..dir..name]=true
        copy(FileInputStream(ls[n]),out)
      end
    end
  end

  this.update("正在编译...");
  if f.isDirectory() then
    require "permission"
    mainpath=luapath.."main.lua"
    dofile(luapath.."init.lua")
    for k,v in ipairs(user_permission or permission) do
      permission[v]=false
    end
    local ls=f.listFiles()
    for n=0,#ls-1 do
      local name=ls[n].getName()
      if name:find("main%.lua$") then
      elseif name:find("%.lua$") then
        checklib(luapath..name)
        local path,err=console.build(luapath..name)
        if path then
          entry=ZipEntry("assets/"..name)
          out.putNextEntry(entry)
          replace["assets/"..name]=true
          copy(FileInputStream(File(path)),out)
        else
          table.insert(errbuffer,err)
        end
      elseif name=="icon.png" then
        entry=ZipEntry("res/drawable/"..name)
        out.putNextEntry(entry)
        replace["res/drawable/"..name]=true
        copy(FileInputStream(ls[n]),out)
        reicon=true
      elseif name=="welcome.png" then
        entry=ZipEntry("res/drawable/"..name)
        out.putNextEntry(entry)
        replace["res/drawable/"..name]=true
        copy(FileInputStream(ls[n]),out)
        rewelcome=true
      elseif ls[n].isDirectory() then
        addDir(out,name.."/",ls[n])
      elseif ls[n].isFile() and (not ((name:find("%.luac$")) or (name:find("%.apk$")))) then
        entry=ZipEntry("assets/"..name)
        out.putNextEntry(entry)
        replace["assets/"..name]=true
        copy(FileInputStream(ls[n]),out)
      end
    end
  else
    mainpath=luapath
  end

  this.update("正在打包...");
  while entries.hasMoreElements () do
    local entry=entries.nextElement ()
    if replace[entry.getName()] then
    elseif not entry.getName():find("luadoc") then
      out.putNextEntry(entry)
      if entry.getName() == "AndroidManifest.xml" then
        local list=ArrayList()
        local xml=AXmlDecoder.read(list, zip.getInputStream(entry))
        local req={
          [activity.getPackageName()]=packagename,
          [info.nonLocalizedLabel]=appname,
          [ver]=appver,
          [".*\\\\.lua"]="",
          [".*\\\\.luac"]="",
        }
        for n=0,list.size()-1 do
          local v=list.get(n)
          if req[v] then
            list.set(n,req[v])
          end
          if permission and permission[v:match("([%w_]+)$")] then
            list.set(n,"")
          end
        end
        xml.write(list,out)
      elseif entry.getName() == "assets/main.lua" then
        checklib(mainpath)
        local path,err=console.build(mainpath)
        if path then
          copy(FileInputStream(File(path)),out)
        else
          table.insert(errbuffer,err)
        end
      else
        if not entry.isDirectory() then
          copy(zip.getInputStream(entry),out)
        end
      end
    end
  end

  out.closeEntry()
  out.close()

  if #errbuffer==0 then
    this.update("正在签名...");
    Signer.sign(tmp,apkpath)
    os.remove(tmp)
    import "android.net.*"
    import "android.content.*"
    i = Intent(Intent.ACTION_VIEW);
    i.setDataAndType(Uri.parse("file://"..apkpath), "application/vnd.android.package-archive");
    i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    this.update("正在打开...");
    activity.startActivity(i);
    return "打包成功:"..apkpath
  else
    os.remove(tmp)
    this.update("打包出错:\n "..table.concat(errbuffer,"\n"));
    return "打包出错:\n "..table.concat(errbuffer,"\n")
  end
end


func={}
func.open=function()
  save()
  list(listview, luadir)
  open_dlg.show()
end
func.new=function()
  save()
  create_t.setText(luadir)
  create_dlg.show()
end

func.create=function()
  save()
  project_dlg=Dialog(activity)
  project_dlg.setTitle("新建工程")
  project_dlg.setContentView(loadlayout(layout.project))
  project_dlg.show()
end
func.openproject=function()
  save()
  list(listview2, luaprojectdir)
  open_dlg2.show()
end

func.save=function()
  save()
  Toast.makeText(activity, "文件已保存."..luapath, Toast.LENGTH_SHORT ).show()
end
func.play=function()
  save()
  local p={}
  local e=pcall(loadfile(luadir.."init.lua","bt",p))
  if e then
    activity.newActivity(luadir.."main.lua")
  else
    activity.newActivity(luapath)
  end
end
func.undo=function()
  editor.undo()
end
func.redo=function()
  editor.redo()
end
func.format=function()
  editor.format()
end
func.check= function ()
  local src=editor.getText()
  src=src.toString()
  local _,data=loadstring(src)

  if data then
    local _,_,line,data=data:find(".(%d+).(.+)")
    editor.gotoLine(tonumber(line))
    Toast.makeText(activity,line..":".. data, Toast.LENGTH_SHORT ).show()
  else
    Toast.makeText(activity, "没有语法错误", Toast.LENGTH_SHORT ).show()
  end
end

func.navi=function ()
  local str=editor.getText().toString()
  local fs={}
  indexs={}
  for s,i in str:gmatch("([%w%._]* *=? *function *[%w%._]*%b())()") do
    i=utf8.len(str,1,i)-1
    s=s:gsub("^ +","")
    table.insert(fs,s)
    table.insert(indexs,i)
    fs[s]=i
  end
  local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(fs))
  navi_list.setAdapter(adapter)
  navi_dlg.show()
end

func.seach=function ()
  editor.search()
end

func.gotoline=function ()
  editor.gotoLine()
end

func.luac=function()
  save()
  local path,str=console.build(luapath)
  if path then
    Toast.makeText(activity, "编译完成: "..path, Toast.LENGTH_SHORT ).show()
  else
    Toast.makeText(activity, "编译出错: "..str, Toast.LENGTH_SHORT ).show()
  end
end

func.build=function()
  save()
  local p={}
  local e=pcall(loadfile(luadir.."init.lua","bt",p))
  if e then
    --Toast.makeText(activity, "正在打包..", Toast.LENGTH_SHORT ).show()
    activity.newTask(bin,update,callback).execute{luadir,p.appname,p.appver,p.packagename,luadir..p.appname..".apk"}
    bin_dlg.show()
    return nil
  end
  apkname=luapath:match("(%w+)%.lua$")
  apkname=apkname or "demo"
  packagename="com.androlua."..apkname
  local luadir="/sdcard/androlua/"
  apkpath=luadir..apkname..".apk"

  luaPath.setText(luapath)
  appName.setText(apkname)
  appVer.setText("1.0")
  packageName.setText(packagename)
  apkPath.setText(apkpath)
  build_dlg.show()
end

buildfile=function()
  Toast.makeText(activity, "正在打包..", Toast.LENGTH_SHORT ).show()
  task(bin,luaPath.getText().toString(),appName.getText().toString(),appVer.getText().toString(),packageName.getText().toString(),apkPath.getText().toString(),function(s)status.setText(s or "打包出错!")end)
end

func.logcat=function()
  activity.newActivity("logcat")
end

func.help=function()
  activity.newActivity("help")
end

func.manual=function()
  activity.newActivity("luadoc")
end

function onMenuItemSelected(id,item)
  switch(item){
    default=function()
      print("功能开发中。。。")
    end,
    [optmenu.play]=func.play,
    [optmenu.undo]=func.undo,
    [optmenu.redo]=func.redo,
    [optmenu.file_open]=func.open,
    [optmenu.file_save]=func.save,
    [optmenu.file_new]=func.new,
    [optmenu.file_build]=func.luac,
    [optmenu.project_open]=func.openproject,
    [optmenu.project_build]=func.build,
    [optmenu.project_create]=func.create,
    [optmenu.code_format]=func.format,
    [optmenu.code_check]=func.check,
    [optmenu.goto_line]=func.gotoline,
    [optmenu.goto_func]=func.navi,
    [optmenu.goto_seach]=func.seach,
    [optmenu.more_logcat]=func.logcat,
    [optmenu.more_help]=func.help,
    [optmenu.more_manual]=func.manual,
  }
end

activity.setContentView(loadlayout(layout.main))

function onCreate()
  if pcall(read,luapath) then
    last=last or 0
    if last < editor.getText().length() then
      editor.setSelection(last)
    end
  else
    luapath=luadir.."new.lua"
    pcall(read,luapath)
  end
end
function onActivityResult(req,res,intent)
  if res~=0 then
    local data=intent.getStringExtra("data")
    local _,_,line=data:find(":(%d+):")
    editor.gotoLine (tonumber(line))
  end
end

function onStop()
  save()
  --Toast.makeText(activity, "文件已保存."..luapath, Toast.LENGTH_SHORT ).show()
  f=io.open(luaconf,"wb")
  f:write( string.format("luapath=%q\nlast=%d",luapath, editor. getSelectionEnd() ))
  f:close()
end
--创建对话框
navi_dlg=Dialog(activity)
navi_dlg.setTitle("导航")
navi_list=ListView(activity)
navi_list.onItemClick=function(parent, v, pos,id)
  editor.setSelection(indexs[pos+1])
  navi_dlg.hide()
end
navi_dlg.setContentView(navi_list)

open_dlg=Dialog(activity)
open_dlg.setTitle("打开")
open_title=TextView(activity)
listview=ListView(activity)
listview.addHeaderView(open_title)
listview.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent, v, pos,id)
    open(v)
  end
})

open_dlg.setContentView(listview)


open_dlg2=Dialog(activity)
open_dlg2.setTitle("打开工程")
listview2=ListView(activity)
listview2.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent, v, pos,id)
    luadir=luaprojectdir..tostring(v.Text)
    read(string.format("%smain.lua",luadir))
    open_dlg2.hide()
    Toast.makeText(activity, "打开工程."..tostring(v.Text), Toast.LENGTH_SHORT ).show()
  end
})

open_dlg2.setContentView(listview2)


create_dlg=Dialog(activity)
create_dlg.setTitle("新建")
create_dlg.setContentView(loadlayout(layout.create))

help_dlg=Dialog(activity,android.R.style.Theme_Holo_Light)
help_dlg.setTitle("帮助")
help_dlg.setContentView(loadlayout(layout.help))

build_dlg=Dialog(activity)
build_dlg.setTitle("打包")
build_dlg.setContentView(loadlayout(layout.build))

bin_dlg=ProgressDialog(activity);
bin_dlg.setTitle("正在打包");
bin_dlg.setMax(100);


