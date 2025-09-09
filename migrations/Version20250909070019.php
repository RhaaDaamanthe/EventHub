<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250909070019 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE events ADD registrations_id INT NOT NULL');
        $this->addSql('ALTER TABLE events ADD CONSTRAINT FK_5387574A8279080 FOREIGN KEY (registrations_id) REFERENCES registrations (id)');
        $this->addSql('CREATE INDEX IDX_5387574A8279080 ON events (registrations_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE events DROP FOREIGN KEY FK_5387574A8279080');
        $this->addSql('DROP INDEX IDX_5387574A8279080 ON events');
        $this->addSql('ALTER TABLE events DROP registrations_id');
    }
}
