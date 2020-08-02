# Generated by Django 2.2.1 on 2019-09-14 03:30

import autoslug.fields
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import simple_history.models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('archive', '0024_historicalentity_historicalmedia'),
    ]

    operations = [
        migrations.CreateModel(
            name='HistoricalProject',
            fields=[
                ('id', models.IntegerField(auto_created=True, blank=True, db_index=True, verbose_name='ID')),
                ('is_visible', models.BooleanField(default=True)),
                ('title', models.CharField(max_length=200)),
                ('statement', models.TextField(blank=True, default='')),
                ('slug', autoslug.fields.AutoSlugField(editable=False, populate_from='get_slug')),
                ('history_id', models.AutoField(primary_key=True, serialize=False)),
                ('history_date', models.DateTimeField()),
                ('history_change_reason', models.CharField(max_length=100, null=True)),
                ('history_type', models.CharField(choices=[('+', 'Created'), ('~', 'Changed'), ('-', 'Deleted')], max_length=1)),
                ('history_user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'historical project',
                'ordering': ('-history_date', '-history_id'),
                'get_latest_by': 'history_date',
            },
            bases=(simple_history.models.HistoricalChanges, models.Model),
        ),
        migrations.DeleteModel(
            name='HistoricalEntity',
        ),
    ]