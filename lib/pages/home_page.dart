import 'package:flutter/material.dart';
import 'package:nutricao_app/components/principal_page.dart';
import 'package:nutricao_app/pages/profile_logout.dart';
import 'search_page.dart';
import 'add_foods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [PrincipalPage(), Search(), AddFoods(), ProfileLogout()],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: paginaAtual,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 30,
              color: Color.fromRGBO(219, 150, 102, 100),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                size: 30, color: Color.fromRGBO(219, 150, 102, 100)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,
                size: 30, color: Color.fromRGBO(219, 150, 102, 100)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3,
                size: 30, color: Color.fromRGBO(219, 150, 102, 100)),
            label: '',
          ),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Image.asset('assets/Banner.png', fit: BoxFit.fitWidth),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         currentIndex: 0,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, size: 30),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, size: 30),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add, size: 30),
//             label: '',
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.person_2, size: 30),
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
