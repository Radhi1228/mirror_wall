import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../../../componets/network/provider/network_provider.dart';
import '../../../componets/network/view/network_screen.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerW;
  HomeProvider? providerR;
  InAppWebViewController? webView;
  PullToRefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().onProgress();
    refreshController = PullToRefreshController(
      onRefresh: () {
        webView!.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<HomeProvider>();
    providerR = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goggle"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          providerR!.getBookmarkData();
                          showBookMarks();

                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("All Bookmarks"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          searchBox();
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.content_paste_search_outlined,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Search Engine"),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
      body: context.watch<NetworkProvider>().isInterNet
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchBar(
                  onTap: () {},
                  onChanged: (value) {},
                  leading: const Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 20,
                      ),
                      // TextFormField(
                      //   decoration: const InputDecoration(label: Text("Search")),
                      // )
                    ],
                  ),
                ),
                Expanded(
                    child: InAppWebView(
                        initialUrlRequest:
                            URLRequest(url: WebUri("https://www.google.com")),
                        onLoadStart: (controller, url) {
                          webView = controller;
                        },
                        onLoadStop: (controller, url) {
                          webView = controller;
                        },
                        pullToRefreshController: PullToRefreshController(
                          onRefresh: () {},
                        ),
                        onProgressChanged: (controller, progress) {
                          providerR!.checkLinearPrograss(progress / 100);
                          webView = controller;
                          if (progress == 100) {
                            refreshController?.endRefreshing();
                          }
                        })),
              ],
            )
          : const NetworkWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  webView!.loadUrl(
                      urlRequest:
                          URLRequest(url: WebUri("https://www.google.com")));
                },
                icon: const Icon(Icons.home_outlined),
                color: Colors.black,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () async{
                  String url = (await webView!.getUrl()).toString();
                  providerR!.setBookmarkData(url);
                },
                icon: const Icon(Icons.bookmark_add_outlined),
                color: Colors.black,
              ),
              label: "Bookmark"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  webView!.goBack();
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
              ),
              label: "back"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  webView!.reload();
                },
                icon: const Icon(Icons.refresh),
                color: Colors.black,
              ),
              label: "refresh"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  webView!.goForward();
                },
                icon: const Icon(Icons.arrow_forward),
                color: Colors.black,
              ),
              label: "Forward"),

        ],
      ),
    );
  }

  void searchBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Column(
              children: [
                RadioListTile(
                  value: "Google",
                  groupValue: providerW!.isChoice,
                  onChanged: (value) {
                    providerR!.checkUi(value);
                    webView!.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://www.google.com"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  title: const Text("Google"),
                ),
                RadioListTile(
                  value: "Amazon",
                  groupValue: providerW!.isChoice,
                  onChanged: (value) {
                    providerR!.checkUi(value);
                    webView!.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://www.amazon.in/?&tag=googhydrabk1-21&ref=pd_sl_7hz2t19t5c_e&adgrpid=155259815513&hvpone=&hvptwo=&hvadid=674842289437&hvpos=&hvnetw=g&hvrand=16586999774530680403&hvqmt=e&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9062189&hvtargid=kwd-10573980&hydadcr=14453_2316415&gad_source=1"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  title: const Text("Amazon"),
                ),
                RadioListTile(
                  value: "Figma",
                  groupValue: providerW!.isChoice,
                  onChanged: (value) {
                    providerR!.checkUi(value);
                    webView!.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://www.figma.com/files/team/1370726361915317820/recents-and-sharing/recently-viewed?fuid=1370726359605894825"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  title: const Text("Figma"),
                ),
                RadioListTile(
                  value: "LIC",
                  groupValue: providerW!.isChoice,
                  onChanged: (value) {
                    providerR!.checkUi(value);
                    webView!.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://licindia.in/?utm_source=Google&utm_medium=CPC&utm_campaign=Search-Generic-Life-Insurance-LIC-Main-Page-PD&gad_source=1&gclid=CjwKCAjwm_SzBhAsEiwAXE2Cv_Wl3ZS486GqFiTMYMnqDJIc9GXZUGnp9YZr5z0773OV6JDiStVQGhoCLvUQAvD_BwE"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  title: const Text("LIC"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
  void showBookMarks() {
    showModalBottomSheet(
        context: context,
        builder: (context) =>
            Padding(padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(itemCount:providerR!.bookMark.length,itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            webView!.loadUrl(
                                urlRequest: URLRequest(url: WebUri(providerW!.bookMark[index])));
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Text(providerW!.bookMark[index]),));
                    },),
                  ),
                ],
              ),)
    );
  }
}

