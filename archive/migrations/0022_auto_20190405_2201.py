# Generated by Django 2.1.7 on 2019-04-05 22:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('archive', '0021_auto_20190403_2225'),
    ]

    operations = [
        migrations.CreateModel(
            name='Reference',
            fields=[
                ('entity_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='archive.Entity')),
                ('publication_date', models.DateField(blank=True, null=True)),
                ('publication', models.CharField(blank=True, default='', max_length=200)),
                ('author', models.CharField(blank=True, default='', max_length=200)),
                ('url', models.URLField(blank=True, default='')),
            ],
            options={
                'ordering': ['-publication_date'],
            },
            bases=('archive.entity',),
        ),
        migrations.AlterModelOptions(
            name='art',
            options={'ordering': ['-year'], 'verbose_name_plural': 'art'},
        ),
    ]
