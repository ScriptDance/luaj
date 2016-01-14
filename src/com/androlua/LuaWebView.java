package com.androlua;

import android.content.*;
import android.graphics.*;
import android.net.http.*;
import android.os.*;
import android.view.*;
import android.webkit.*;
import com.androlua.LuaWebView.*;

public class LuaWebView extends WebView
{

	public LuaWebView(Main context)
	{
		super(context);

		getSettings().setJavaScriptEnabled(true);
		addJavascriptInterface(new JavaScriptinterface(context), "androlua");
		requestFocus();
		setWebViewClient(new WebViewClient()
			{
				public boolean shouldOverrideUrlLoading(WebView view, String url)
				{
					view.loadUrl(url);  
					return true;
				}
			}
		);
	}

	public boolean onKeyDown(int keyCode, KeyEvent event)
	{       
		if ((keyCode == KeyEvent.KEYCODE_BACK) && canGoBack())
		{       
            goBack();       
			return true;       
        }       
		return super.onKeyDown(keyCode, event);       
    }

	@Override
	public void setOnKeyListener(View.OnKeyListener l)
	{
		// TODO: Implement this method
		super.setOnKeyListener(l);
	}


	public void setWebViewClient(LuaWebViewClient client)
	{
		// TODO: Implement this method
		super.setWebViewClient(new SimpleLuaWebViewClient(client));
	}

	public class JavaScriptinterface
	{

		private Main mMain;
		public JavaScriptinterface(Main  main)
		{
			mMain = main;
		}

		@JavascriptInterface
		public Object callLuaFunnction(String name)
		{
			return mMain.runFunc(name);
		}
		@JavascriptInterface
		public Object callLuaFunnction(String name, String arg)
		{
			return mMain.runFunc(name, arg);
		}

		/*@JavascriptInterface
		 public Object callLuaFunnction(String name,double arg)
		 {
		 return mMain.runFunc(name,arg);
		 }*/

		@JavascriptInterface
		public Object doLuaString(String name)
		{
			return mMain.doString(name);
		}
	}

	private class SimpleLuaWebViewClient extends WebViewClient
	{

		private LuaWebView.LuaWebViewClient mLuaWebViewClient;

		public SimpleLuaWebViewClient(LuaWebViewClient wvc)
		{
			mLuaWebViewClient = wvc;
		}

		public boolean shouldOverrideUrlLoading(WebView view, String url)
		{
			return mLuaWebViewClient.shouldOverrideUrlLoading(view, url);
		}

		public void onPageStarted(WebView view, String url, Bitmap favicon)
		{
			mLuaWebViewClient.onPageStarted(view, url, favicon);
		}

		public void onPageFinished(WebView view, String url)
		{
			mLuaWebViewClient.onPageFinished(view, url);
		}

		public void onLoadResource(WebView view, String url)
		{
			mLuaWebViewClient.onLoadResource(view, url);
		}

		public WebResourceResponse shouldInterceptRequest(WebView view, String url)
		{
			return mLuaWebViewClient.shouldInterceptRequest(view, url);
		}

		@Deprecated
		public void onTooManyRedirects(WebView view, Message cancelMsg,
									   Message continueMsg)
		{
			cancelMsg.sendToTarget();
		}

		public void onReceivedError(WebView view, int errorCode,
									String description, String failingUrl)
		{
			mLuaWebViewClient.onReceivedError(view, errorCode, description, failingUrl);
		}

		public void onFormResubmission(WebView view, Message dontResend,
									   Message resend)
		{
			dontResend.sendToTarget();
		}

		public void doUpdateVisitedHistory(WebView view, String url,
										   boolean isReload)
		{
			mLuaWebViewClient.doUpdateVisitedHistory(view, url, isReload);
		}

		public void onReceivedSslError(WebView view, SslErrorHandler handler,
									   SslError error)
		{
			handler.cancel();
		}

		public void onProceededAfterSslError(WebView view, SslError error)
		{
			mLuaWebViewClient.onProceededAfterSslError(view, error);
		}

		public void onReceivedClientCertRequest(WebView view,
												ClientCertRequest handler, String host_and_port)
		{
			handler.cancel();
		}

		public void onReceivedHttpAuthRequest(WebView view,
											  HttpAuthHandler handler, String host, String realm)
		{
			handler.cancel();
		}

		public boolean shouldOverrideKeyEvent(WebView view, KeyEvent event)
		{
			return mLuaWebViewClient.shouldOverrideKeyEvent(view, event);
		}

		public void onUnhandledKeyEvent(WebView view, KeyEvent event)
		{
			mLuaWebViewClient.onUnhandledKeyEvent(view, event);
		}

		public void onScaleChanged(WebView view, float oldScale, float newScale)
		{
			mLuaWebViewClient.onScaleChanged(view, oldScale, newScale);
		}

		public void onReceivedLoginRequest(WebView view, String realm,
										   String account, String args)
		{
			mLuaWebViewClient.onReceivedLoginRequest(view, realm, account, args);
		}
	}

	public interface LuaWebViewClient
	{

		public boolean shouldOverrideUrlLoading(WebView view, String url)


		public void onPageStarted(WebView view, String url, Bitmap favicon)


		public void onPageFinished(WebView view, String url)


		public void onLoadResource(WebView view, String url)


		public WebResourceResponse shouldInterceptRequest(WebView view,
														  String url)


		@Deprecated
		public void onTooManyRedirects(WebView view, Message cancelMsg,
									   Message continueMsg)


		// These ints must match up to the hidden values in EventHandler.
		/** Generic error */
		public static final int ERROR_UNKNOWN = -1;
		/** Server or proxy hostname lookup failed */
		public static final int ERROR_HOST_LOOKUP = -2;
		/** Unsupported authentication scheme (not basic or digest) */
		public static final int ERROR_UNSUPPORTED_AUTH_SCHEME = -3;
		/** User authentication failed on server */
		public static final int ERROR_AUTHENTICATION = -4;
		/** User authentication failed on proxy */
		public static final int ERROR_PROXY_AUTHENTICATION = -5;
		/** Failed to connect to the server */
		public static final int ERROR_CONNECT = -6;
		/** Failed to read or write to the server */
		public static final int ERROR_IO = -7;
		/** Connection timed out */
		public static final int ERROR_TIMEOUT = -8;
		/** Too many redirects */
		public static final int ERROR_REDIRECT_LOOP = -9;
		/** Unsupported URI scheme */
		public static final int ERROR_UNSUPPORTED_SCHEME = -10;
		/** Failed to perform SSL handshake */
		public static final int ERROR_FAILED_SSL_HANDSHAKE = -11;
		/** Malformed URL */
		public static final int ERROR_BAD_URL = -12;
		/** Generic file error */
		public static final int ERROR_FILE = -13;
		/** File not found */
		public static final int ERROR_FILE_NOT_FOUND = -14;
		/** Too many requests during this load */
		public static final int ERROR_TOO_MANY_REQUESTS = -15;

		public void onReceivedError(WebView view, int errorCode,
									String description, String failingUrl)


		public void onFormResubmission(WebView view, Message dontResend,
									   Message resend)
		

		public void doUpdateVisitedHistory(WebView view, String url,
										   boolean isReload)


		public void onReceivedSslError(WebView view, SslErrorHandler handler,
									   SslError error)


		public void onProceededAfterSslError(WebView view, SslError error)


		public void onReceivedClientCertRequest(WebView view,
												ClientCertRequest handler, String host_and_port)


		public void onReceivedHttpAuthRequest(WebView view,
											  HttpAuthHandler handler, String host, String realm)


		public boolean shouldOverrideKeyEvent(WebView view, KeyEvent event)


		public void onUnhandledKeyEvent(WebView view, KeyEvent event)


		public void onScaleChanged(WebView view, float oldScale, float newScale)


		public void onReceivedLoginRequest(WebView view, String realm,
										   String account, String args)

	}
}
