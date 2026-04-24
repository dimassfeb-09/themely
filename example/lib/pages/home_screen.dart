import 'package:flutter/material.dart';
import 'package:themely/themely.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeColors.cardSurface,
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeBanner(),
            SizedBox(height: 24),
            HomeSectionTitle(title: 'Categories'),
            SizedBox(height: 16),
            HomeCategories(),
            SizedBox(height: 32),
            HomeSectionTitle(title: 'Flash Sale'),
            SizedBox(height: 16),
            HomeProductGrid(),
            SizedBox(height: 40),
            HomeThemeSettings(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Icon(
            Icons.shopping_bag_rounded,
            color: context.themeColors.buttonBackground,
          ),
          const SizedBox(width: 8),
          Text(
            "Themely Store",
            style: TextStyle(
              color: context.themeColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: context.themeColors.textPrimary),
        ),
        IconButton(
          onPressed: () => context.themeController.toggleDark(),
          icon: ThemeIcon(light: Icons.dark_mode, dark: Icons.light_mode),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.buttonBackground.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Big Sale\nUp to 50%',
                  style: TextStyle(
                    color: context.themeColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.themeColors.buttonBackground,
                    foregroundColor: context.themeColors.textInverse,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Shop Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSectionTitle extends StatelessWidget {
  final String title;

  const HomeSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.themeColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              color: context.themeColors.buttonBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.phone_iphone, 'label': 'Phones'},
      {'icon': Icons.laptop_mac, 'label': 'Laptops'},
      {'icon': Icons.watch, 'label': 'Watches'},
      {'icon': Icons.headphones, 'label': 'Audio'},
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Column(
            children: [
              ThemeAnimatedColor(
                light: Colors.grey.shade200,
                dark: Colors.grey.shade800,
                amoled: Colors.grey.shade900,
                builder: (context, color) => Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    cat['icon'] as IconData,
                    color: context.themeColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                cat['label'] as String,
                style: TextStyle(
                  color: context.themeColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'Wireless Earbuds',
        'price': '\$49.99',
        'image': 'https://picsum.photos/id/1/400/400',
      },
      {
        'name': 'Smart Watch X',
        'price': '\$199.00',
        'image': 'https://picsum.photos/id/2/400/400',
      },
      {
        'name': 'Laptop Pro 15"',
        'price': '\$1299.00',
        'image': 'https://picsum.photos/id/3/400/400',
      },
      {
        'name': 'Mechanical Keyboard',
        'price': '\$89.50',
        'image': 'https://picsum.photos/id/4/400/400',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ThemeDecoration(
          light: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          dark: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          amoled: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    product['image']!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name']!,
                      style: TextStyle(
                        color: context.themeColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['price']!,
                      style: TextStyle(
                        color: context.themeColors.buttonBackground,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeThemeSettings extends StatelessWidget {
  const HomeThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.buttonBackground.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.themeColors.buttonBackground.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: context.themeColors.buttonBackground),
              const SizedBox(width: 8),
              Text(
                'Theme Settings',
                style: TextStyle(
                  color: context.themeColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ThemeButton(
                  mode: AppThemeMode.light,
                  icon: Icons.light_mode,
                  label: 'Light',
                ),
                const SizedBox(width: 8),
                _ThemeButton(
                  mode: AppThemeMode.dark,
                  icon: Icons.dark_mode,
                  label: 'Dark',
                ),
                const SizedBox(width: 8),
                _ThemeButton(
                  mode: AppThemeMode.amoled,
                  icon: Icons.brightness_high,
                  label: 'AMOLED',
                ),
                const SizedBox(width: 8),
                _ThemeButton(
                  mode: AppThemeMode.system,
                  icon: Icons.phone_android,
                  label: 'System',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  final AppThemeMode mode;
  final IconData icon;
  final String label;

  const _ThemeButton({
    required this.mode,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = context.themeController.activeMode == mode;

    return ThemeAnimatedColor(
      light: isActive
          ? context.themeColors.buttonBackground
          : Colors.transparent,
      dark: isActive
          ? context.themeColors.buttonBackground
          : Colors.transparent,
      amoled: isActive
          ? context.themeColors.buttonBackground
          : Colors.transparent,
      builder: (context, bgColor) {
        final contentColor = isActive
            ? context.themeColors.textInverse
            : context.themeColors.textPrimary;

        return InkWell(
          onTap: () => context.themeController.setMode(mode),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isActive
                    ? Colors.transparent
                    : context.themeColors.dividerColor,
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: contentColor),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: contentColor,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
