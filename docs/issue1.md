Olá Marcelo,
Parabens mais uma vez pela sua fantástica contribuição no desenvolvimento deste package, Themed. 
Desde que conheci seu trabalho com o async_redux, o qual utilizo muito, mais admiro seu trabalho e desejo seu sucesso e crescimento pessoal e profissional. Deus sabe o quanto tenho orado por vc e sua familia.
Mas vamos a minha duvida, talvez uma issue. Decida por favor.
Considere estes temas do seu exemplo:
```
MyTheme
  static const primary = ColorRef(Colors.orange);
  static const onPrimary = ColorRef(Colors.black);
anotherTheme
Map<ThemeRef, Object> anotherTheme = {
  MyTheme.primary: Colors.grey,
  MyTheme.onPrimary: Colors.yellow,
```
No exemplo deste package acrescentei apenas este código para alterar a cor do appBar e ele tem executado corretamente a mudança da cor (a cor do background da appBar muda alternadamente com a cor de seu texto):
```dart
 appBarTheme: const AppBarTheme(
            backgroundColor: MyTheme.primary,
            foregroundColor: MyTheme.onPrimary,
          ),
```
Aplicando este mesmo código a meu projeto ele NÃO tem mudado a cor do texto da appBar alternadamente com o background na appBar, na HomePage de onde parte o click no action para mudar a cor, MAS corretamente nas demais telas.
Este é o código do meu main.dart.
```dart
    return StoreProvider<AppState>(
      store: store,
      child: Themed(
        defaultTheme: myThemeOrange,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          title: 'ClassFrase',
          navigatorKey: navigatorKey,
          routes: Routes.routes,
          initialRoute: '/',
          theme: ThemeData(
            primaryColor: MyTheme.primary,
            appBarTheme: const AppBarTheme(
              backgroundColor: MyTheme.primary,
              foregroundColor: MyTheme.onPrimary,
            ),
           ...
```
O fluxo do initialRoute segue: SplashConnector -> HomePageConnector -> HomePage. Onde contem o botão no action para mudança de cor. A HomePage muda apenas o background e nao a cor do texto. Mas a SecondPage sim muda conforme seu exemplo.

Você tem alguma sugestão com tão pouca informação que eu dei ? Pois os demais passos são iguais aos que vc orienta no exemplo.

