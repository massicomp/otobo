# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2019 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2020 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --


package Kernel::Output::HTML::Notification::AgentSessionLimit;

use parent 'Kernel::Output::HTML::Base';

use strict;
use warnings;
use utf8;

our @ObjectDependencies = (
    'Kernel::Output::HTML::Layout',
    'Kernel::System::AuthSession',
);

sub Run {
    my ( $Self, %Param ) = @_;

    # currently an OTOBOBusiness 'feature'
    return '';

    # Check if the agent session limit for the prior warning is reached
    #   and save the message for the translation and the output.
    my $AgentSessionLimitPriorWarningMessage
        = $Kernel::OM->Get('Kernel::System::AuthSession')->CheckAgentSessionLimitPriorWarning();

    return '' if !$AgentSessionLimitPriorWarningMessage;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Output = $LayoutObject->Notify(
        Data     => $LayoutObject->{LanguageObject}->Translate($AgentSessionLimitPriorWarningMessage),
        Priority => 'Warning',
    );

    return $Output;
}

1;