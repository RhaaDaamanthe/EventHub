<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250908123247 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE events DROP FOREIGN KEY FK_5387574A8279080');
        $this->addSql('DROP INDEX IDX_5387574A8279080 ON events');
        $this->addSql('ALTER TABLE events DROP registrations_id');
        $this->addSql('ALTER TABLE registrations ADD event_id INT DEFAULT NULL, CHANGE user_id_id user_id_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE registrations ADD CONSTRAINT FK_53DE51E771F7E88B FOREIGN KEY (event_id) REFERENCES events (id)');
        $this->addSql('CREATE INDEX IDX_53DE51E771F7E88B ON registrations (event_id)');
        $this->addSql('ALTER TABLE users CHANGE email email VARCHAR(180) NOT NULL, CHANGE password password VARCHAR(255) NOT NULL, CHANGE roles roles JSON NOT NULL');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_IDENTIFIER_EMAIL ON users (email)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE events ADD registrations_id INT NOT NULL');
        $this->addSql('ALTER TABLE events ADD CONSTRAINT FK_5387574A8279080 FOREIGN KEY (registrations_id) REFERENCES registrations (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE INDEX IDX_5387574A8279080 ON events (registrations_id)');
        $this->addSql('ALTER TABLE registrations DROP FOREIGN KEY FK_53DE51E771F7E88B');
        $this->addSql('DROP INDEX IDX_53DE51E771F7E88B ON registrations');
        $this->addSql('ALTER TABLE registrations DROP event_id, CHANGE user_id_id user_id_id INT NOT NULL');
        $this->addSql('DROP INDEX UNIQ_IDENTIFIER_EMAIL ON users');
        $this->addSql('ALTER TABLE users CHANGE email email VARCHAR(100) NOT NULL, CHANGE roles roles LONGTEXT NOT NULL COMMENT \'(DC2Type:array)\', CHANGE password password VARCHAR(200) NOT NULL');
    }
}
