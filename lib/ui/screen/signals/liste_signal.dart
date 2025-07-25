import 'package:flutter/material.dart';
import 'package:safe_guinee/ui/widgets/custom_signal_card.dart';

class ListeSignal extends StatelessWidget {
  const ListeSignal({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // nombre de tabs
      child: Column(
        children: [
          
          // const SizedBox(height: 20), // pour laisser un peu d'espace en haut
          // TabBar sans AppBar
          const TabBar(
            isScrollable: true,
            labelColor: Colors.indigoAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: [
              Tab(
                child: Row(
                  
                  children: [
                    Icon(Icons.select_all),
                    SizedBox(width: 5),
                    Text("Tous"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.done_outline_rounded),
                    SizedBox(width: 5),
                    Text("Resolus"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.task_alt_outlined),
                    SizedBox(width: 5),
                    Text(" Non Resolus"),
                  ],
                ),
              ),
            ],
          ),

          // Le contenu des tabs
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CustomSignalCard();
                  },
                ),
                const Center(child: Text("Contenu des signalements validés")),
                const Center(child: Text("Contenu des signalements rejetés")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
