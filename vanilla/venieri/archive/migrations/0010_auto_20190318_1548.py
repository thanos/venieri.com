# Generated by Django 2.1.7 on 2019-03-18 15:48

from django.db import migrations, models
import django.db.models.deletion
import tagulous.models.fields
import tagulous.models.models


class Migration(migrations.Migration):

    dependencies = [
        ('archive', '0009_category'),
    ]

    operations = [
        migrations.CreateModel(
            name='Tagulous_Entity_tags',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, unique=True)),
                ('slug', models.SlugField()),
                ('count', models.IntegerField(default=0, help_text='Internal counter of how many times this tag is in use')),
                ('protected', models.BooleanField(default=False, help_text='Will not be deleted when the count reaches 0')),
                ('path', models.TextField()),
                ('label', models.CharField(help_text='The name of the tag, without ancestors', max_length=255)),
                ('level', models.IntegerField(default=1, help_text='The level of the tag in the tree')),
                ('parent', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='children', to='archive.Tagulous_Entity_tags')),
            ],
            options={
                'ordering': ('name',),
                'abstract': False,
            },
            bases=(tagulous.models.models.BaseTagTreeModel, models.Model),
        ),
        migrations.AlterUniqueTogether(
            name='tags',
            unique_together=set(),
        ),
        migrations.RemoveField(
            model_name='tags',
            name='parent',
        ),
        migrations.AlterField(
            model_name='entity',
            name='tags',
            field=tagulous.models.fields.TagField(_set_tag_meta=True, force_lowercase=True, help_text='Enter a comma-separated tag string', to='archive.Tagulous_Entity_tags', tree=True),
        ),
        migrations.DeleteModel(
            name='Tags',
        ),
        migrations.AlterUniqueTogether(
            name='tagulous_entity_tags',
            unique_together={('slug', 'parent')},
        ),
    ]