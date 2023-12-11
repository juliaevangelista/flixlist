import 'package:flutter/material.dart';
import 'package:flixlist/utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _performSearch(String query) {
    // Aqui você pode adicionar a lógica de pesquisa real, por exemplo, chamar uma API
    // Neste exemplo, estamos usando uma lista fictícia de resultados
    List<String> results = ['Result 1', 'Result 2', 'Result 3'];

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Digite sua pesquisa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchResults[index]),
                          // Adicione a lógica de navegação para os resultados aqui
                          onTap: () {
                            // Exemplo: Navegar para a tela de detalhes
                            Navigator.pushNamed(context, '/details');
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text('Nenhum resultado encontrado'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
