import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:service_design/components/eike_app_bar.dart';
import 'package:service_design/theming/eike_theme.dart';
import 'package:service_url_launcher/presentation/bloc/url_launcher_bloc.dart';

class MyClass {
  int get value => 1200;
}

class ImprintScreen extends StatelessWidget {
  const ImprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(
        title: 'Impressum',
      ),
      body: ListView(
        padding: EikeTheme.pagePadding,
        children: [
          Html(
            data: impressumHtml,
            extensions: [
              TagExtension(
                tagsToExtend: {"icon-button"},
                builder: (extensionContext) {
                  final href = extensionContext.attributes['href'] ?? '';
                  final icon = extensionContext.attributes['icon'] == 'email'
                      ? Icons.email_outlined
                      : Icons.phone_outlined;
                  final label = extensionContext.innerHtml;

                  return TextButton.icon(
                    onPressed: () {
                      final uri = Uri.tryParse(href);
                      if (uri != null) {
                        BlocProvider.of<UrlLauncherBloc>(context).add(
                          UrlLauncherEvent.onLaunchUrl(uri),
                        );
                      }
                    },
                    icon: Icon(icon, size: 18),
                    label: Text(label),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

const String impressumHtml = '''
<h2>Anbieter</h2>
<p>Deutscher Fachverband für Psychosoziale Notfallversorgung (DF-PSNV) e.V.<br>
P.-H.-Eggers-Straße 22<br>
24768 Rendsburg<br>
Deutschland</p>

<h2>Vertreten durch</h2>
<p>Volker Schenk (Vorstandsvorsitzender)<br>
Ingo Vigneron (Stellvertreter)</p>

<h2>Kontakt</h2>
<p>E-Mail: eikeapp@df-psnv.de<br>
Telefon: +49 4331 7353705</p>

<icon-button href="mailto:eikeapp@df-psnv.de" icon="email">E-Mail schreiben</icon-button>
<icon-button href="tel:+4943317353705" icon="phone">Anrufen</icon-button>

<h2>Registereintrag</h2>
<p>Eingetragen im Vereinsregister<br>
Registergericht: Amtsgericht Berlin<br>
Registernummer: VR 30959 B</p>
''';
