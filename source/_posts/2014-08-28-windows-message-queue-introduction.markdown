---
layout: post
title: "Windows Message Queue Introduction"
date: 2014-08-28 20:59:07 +0800
comments: true
tags: windows 
---
Windows 的消息队列和消息处理方式一直没有非常系统的学习过。正如某位名人所说的“一知半解，最危险”。
{% blockquote %} 
  “一知半解”就是对事物的吸收囫囵吞枣、不求甚解，导致判断失准而不自知。因为不彻底了解事物，不精准分辨事物细微差异，以致陷入断章取义、冯京当马凉、张飞打岳飞打得满天飞。而且正因为自以为很懂，他甚至听不进去别人的观点、劝告，当然赖之作出的判断，就会差之毫厘失之千里，甚至造成很大的错误。
{% endblockquote %} 

##创建消息循环
系统只会为那些须要消息队列来执行某些操作的线程创建消息队列。如果一个线程创建了一个或多个窗口，那么就必须创建一个消息循环来处理消息队列中的消息。（窗口都会有显示和关闭的消息），这个消息循环会从线程的消息队列中检索消息(`PeekMessage`和`GetMessage`)，然后分发给相应的处理过程。

由于应用程序中系统会把消息分发给各个窗口，所以线程在创建消息循环之前至少要创建一个窗口。传统的应用程序中，应用会WinMain函数中注册一个窗口类作为主窗口，创建和显示窗口，然后启动消息循环。

<!-- more -->
我们可以使用`GetMessage`和`DispatchMessage`函数来创建消息循环。
``` c 
HINSTANCE hinst; 
HWND hwndMain; 
 
int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, 
    LPSTR lpszCmdLine, int nCmdShow) 
{ 
    MSG msg;
    BOOL bRet; 
    WNDCLASS wc; 
    UNREFERENCED_PARAMETER(lpszCmdLine); 
 
    // Register the window class for the main window. 
 
    if (!hPrevInstance) 
    { 
        wc.style = 0; 
        wc.lpfnWndProc = (WNDPROC) WndProc; 
        wc.cbClsExtra = 0; 
        wc.cbWndExtra = 0; 
        wc.hInstance = hInstance; 
        wc.hIcon = LoadIcon((HINSTANCE) NULL, 
            IDI_APPLICATION); 
        wc.hCursor = LoadCursor((HINSTANCE) NULL, 
            IDC_ARROW); 
        wc.hbrBackground = GetStockObject(WHITE_BRUSH); 
        wc.lpszMenuName =  "MainMenu"; 
        wc.lpszClassName = "MainWndClass"; 
 
        if (!RegisterClass(&wc)) 
            return FALSE; 
    } 
 
    hinst = hInstance;  // save instance handle 
 
    // Create the main window. 
 
    hwndMain = CreateWindow("MainWndClass", "Sample", 
        WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, 
        CW_USEDEFAULT, CW_USEDEFAULT, (HWND) NULL, 
        (HMENU) NULL, hinst, (LPVOID) NULL); 
 
    // If the main window cannot be created, terminate 
    // the application. 
 
    if (!hwndMain) 
        return FALSE; 
 
    // Show the window and paint its contents. 
 
    ShowWindow(hwndMain, nCmdShow); 
    UpdateWindow(hwndMain); 
 
    // Start the message loop. 
 
    while( (bRet = GetMessage( &msg, NULL, 0, 0 )) != 0)
    { 
        if (bRet == -1)
        {
            // handle the error and possibly exit
        }
        else
        {
            TranslateMessage(&msg); 
            DispatchMessage(&msg); 
        }
    } 
 
    // Return the exit code to the system. 
 
    return msg.wParam; 
} 

```
##线程，窗口，消息队列，消息循环，消息处理过程
如果一个线程须要消息来处理某些操作，那么可以创建一个（只可以是一个）消息循环来检查消息队列，获取有取的消息并做处理。每个线程有它自己的一个消息队列（如其它线程可以通过PostThreadMessage 来向某个线程发送消息，这个消息会被发到相应的消息队列中），线程可以用PeekMessage来获取消息并处理。线程可以创建一个窗口，这个窗口有自己的消息处理程序如WndProc。线程在接收到消息后可以通过DispatchMessage来分发消息到各个窗口中。

##什么是UI线程
UI线程指的是有窗口，或控件的线程，有消息队列和消息循环。UI线程有以下几个特点
1.  UI线程有一个消息队列，这个消息队列由操作系统分配。在创建第一个窗体时就分配。
2.  UI线程需要一个消息汞（消息循环）来检索消息，然后分发消息给各个窗体或者控件。
3. COM在这个线程止初始化.一个STA（单线程单元需要让许多窗体特征正常运行，因为这些不是线程安全的）COM确保这些特性是线程安全的。
4. 线程不会在任何操作阻塞。
5. UI线程可以创建多个窗体和控件，这些控件都是由一个消息循环来分发消息的。

在Windows中操作系统只会为UI线程创建消息队列。基本上我们只需要一个UI线程。
MSDN： The system does not automatically create a message queue for each thread，Instead, the system creates a message queue only for threads that perform operations which require a message queue.

##消息队列函数
###DispatchMessage
``` cpp C++
LRESULT WINAPI DispatchMessage(
		_In_ const MSG *lpmsg);
```
这个函数会分发消息到窗口的处理过程中，一般和GetMessage一起用。**note: 这个函数会等待窗口处理过程的返回 是阻塞式的**
如果lpmsg指向一个`WM_TIMER`和lParam参数不为空，那么这个lParam指向的函数将会被调用，而不会调用窗口的处理过程。

###PeekMessage
``` c
BOOL WINAPI PeekMessage(
  _Out_     LPMSG lpMsg,
  _In_opt_  HWND hWnd,
  _In_      UINT wMsgFilterMin,
  _In_      UINT wMsgFilterMax,
  _In_      UINT wRemoveMsg
);

```


