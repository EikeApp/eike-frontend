import 'package:eike_app/service_design/components/eike_app_bar.dart';
import 'package:eike_app/service_design/theming/eike_theme.dart';
import 'package:eike_app/service_url_launcher/presentation/bloc/url_launcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class LicenseTextScreen extends StatefulWidget {
  const LicenseTextScreen({
    required this.title,
    required this.assetPath,
    required this.sourceUrl,
    this.notice,
    super.key,
  });

  final String title;
  final String assetPath;
  final String sourceUrl;
  final String? notice;

  @override
  State<LicenseTextScreen> createState() => _LicenseTextScreenState();
}

class _LicenseTextScreenState extends State<LicenseTextScreen> {
  late Future<String> _license;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _license = DefaultAssetBundle.of(context).loadString(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EikeAppBar(title: widget.title),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _license,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Padding(
                  padding: EikeTheme.pagePadding,
                  child: Text('Der Lizenztext konnte nicht geladen werden.'),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scrollbar(
              child: SingleChildScrollView(
                padding: EikeTheme.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.notice case final notice?) ...[
                      SelectableText(
                        notice,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: EikeTheme.verticalComponentSpacingMedium,
                      ),
                    ],
                    widget.assetPath.endsWith('.html')
                        ? SelectionArea(
                            child: Html(
                              data: snapshot.data!,
                              style: {
                                'body': Style(
                                  margin: Margins.zero,
                                  color: context.colors.onSurface,
                                ),
                                'a': Style(color: context.colors.primary),
                                // flutter_html does not apply HTML's ol type
                                // attribute; preserve the legal section labels.
                                'ol[type="a"]': Style(
                                  listStyleType: ListStyleType.lowerAlpha,
                                ),
                                'ol[type="A"]': Style(
                                  listStyleType: ListStyleType.upperAlpha,
                                ),
                                'ol[type="i"]': Style(
                                  listStyleType: ListStyleType.lowerRoman,
                                ),
                              },
                              onLinkTap: (url, _, _) {
                                if (url == null) return;
                                context.read<UrlLauncherBloc>().add(
                                  UrlLauncherEvent.onLaunchUrl(
                                    Uri.parse(widget.sourceUrl).resolve(url),
                                  ),
                                );
                              },
                            ),
                          )
                        : SelectableText(
                            snapshot.data!,
                            style: context.textTheme.bodyMedium,
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
