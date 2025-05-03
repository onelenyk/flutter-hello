class HelloState {
  final DateTime renderTime = DateTime.now();

  final String name = "Nazar Lenyk";
  final String position = "Android Engineer";
  final Social composeHello = Social(
    title: "Compose Hello",
    url: "https://compose.onelenyk.dev/",
  );

  final Social telegram = Social(
    title: "Telegram",
    url: "https://t.me/onelenyk",
  );
  final Social gitHub = Social(
    title: "GitHub",
    url: "https://github.com/onelenyk/",
  );
  final Social linkedIn = Social(
    title: "LinkedIn",
    url: "https://www.linkedin.com/in/onelenyk/",
  );

  final Social resume = Social(
    title: "Resume",
    url: "lenyk_resume.pdf",
  );

  final List<String> translations = [
    "Hello",
    "Привіт",
    "Hola",
    "Bonjour",
    "Hallo",
    "Ciao",
    "Olá",
    "Hej",
    "Hallo",
  ];

  String currentTitle = "Hello";
  final String shortStory =
      "I do love playing with different things: kotlin(android, ktor, cli, kmp, tg bots), flutter, arduino-like, ffmpeg(something)";
}

class Social {
  Social({
    required this.title,
    required this.url,
  });

  final String title;
  final String url;
}