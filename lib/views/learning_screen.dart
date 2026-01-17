import 'package:financio_app/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/learning_viewmodel.dart';
import '../utils/app_colors.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LearningViewModel(),
      child: const _LearningContent(),
    );
  }
}

class _LearningContent extends StatelessWidget {
  const _LearningContent();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LearningViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (vm.step == LearningStep.topics) {
              Navigator.pop(context);
            } else {
              vm.reset(); // step-safe back
            }
          },
        ),
        title: const Text('Learn with Mitra'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          child: _buildStep(vm),
        ),
      ),
    );
  }

  Widget _buildStep(LearningViewModel vm) {
    switch (vm.step) {
      // ───────── TOPICS ─────────
      case LearningStep.topics:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('Choose Level'),
            const SizedBox(height: 12),

            _Card(
              child: DropdownButtonFormField<String>(
                value: vm.level,
                decoration: const InputDecoration(border: InputBorder.none),
                items: const [
                  DropdownMenuItem(value: 'beginner', child: Text('Beginner')),
                  DropdownMenuItem(
                    value: 'intermediate',
                    child: Text('Intermediate'),
                  ),
                  DropdownMenuItem(value: 'advanced', child: Text('Advanced')),
                ],
                onChanged: (v) {
                  vm.level = v!;
                  vm.notifyListeners();
                },
              ),
            ),

            const SizedBox(height: 24),
            const _SectionTitle('Topics'),
            const SizedBox(height: 12),

            ...vm.topics.map(
              (t) => _FeatureTile(
                title: t['title']!,
                subtitle: t['desc']!,
                onTap: () => vm.startLesson(t['title']!),
              ),
            ),
          ],
        );

      // ───────── LOADING ─────────
      case LearningStep.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: CircularProgressIndicator(),
          ),
        );

      // ───────── LESSON (IMAGES HERE) ─────────
      case LearningStep.lesson:
        final images = vm.selectedTopic == null
            ? <String>[]
            : getLessonImages(topic: vm.selectedTopic!, level: vm.level);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GradientHeader(vm.lesson!.title),
            const SizedBox(height: 24),

            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                images.first, // ✅ only one image
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            _RowButtons(onPlay: vm.playVoice, onStop: vm.stopVoice),

            const SizedBox(height: 12),

            _SecondaryButton(
              text: 'Start Quiz',
              onTap: () {
                vm.step = LearningStep.quiz;
                vm.notifyListeners();
              },
            ),
          ],
        );

      // ───────── QUIZ ─────────
      case LearningStep.quiz:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('Quick Quiz'),
            const SizedBox(height: 12),

            ...vm.lesson!.quiz.asMap().entries.map((entry) {
              final i = entry.key;
              final q = entry.value;

              return _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    ...q.options.asMap().entries.map(
                      (o) => RadioListTile<int>(
                        value: o.key,
                        groupValue: vm.answers[i],
                        onChanged: (v) {
                          vm.answers[i] = v!;
                          vm.notifyListeners();
                        },
                        title: Text(o.value),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            _PrimaryButton(text: 'Submit', onTap: vm.submitQuiz),
          ],
        );

      // ───────── RESULT ─────────
      case LearningStep.result:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GradientHeader('Score: ${vm.score}/${vm.lesson!.quiz.length}'),
            const SizedBox(height: 24),

            ...vm.lesson!.quiz.map(
              (q) => _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text('✅ ${q.options[q.correctIndex]}'),
                    const SizedBox(height: 4),
                    Text(
                      'ℹ️ ${q.explanation}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: TextButton(
                onPressed: vm.reset,
                child: const Text('Choose another topic'),
              ),
            ),
          ],
        );
    }
  }
}

/* ───────── UI HELPERS (UNCHANGED) ───────── */

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: child,
    );
  }
}

class _GradientHeader extends StatelessWidget {
  final String text;
  const _GradientHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _PrimaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _SecondaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class _RowButtons extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onStop;

  const _RowButtons({
    required this.onPlay,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPlay,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('🔊 Listen'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: onStop,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('⏹ Stop'),
          ),
        ),
      ],
    );
  }
}

