##########################################
################ Form ####################
##########################################

$ErrorActionPreference = 'SilentlyContinue'
    $wshell = New-Object -ComObject Wscript.Shell
    $Button = [System.Windows.MessageBoxButton]::YesNoCancel
    $ErrorIco = [System.Windows.MessageBoxImage]::Error
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
    }
    # GUI Specs
    # Check if winget is installed
    if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget Already Installed'
    }  
    else{
    # Installing winget from the Microsoft Store
    Write-Host "Winget not found, installing it now."
    $ResultText.text = "`r`n" +"`r`n" + "Installing Winget... Please Wait"
    Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
    $nid = (Get-Process AppInstaller).Id
    Wait-Process -Id $nid
    Write-Host Winget Installed
    $ResultText.text = "`r`n" +"`r`n" + "Winget Installed - Ready for Next Task"
}

$inputXML = @"
<Window x:Class="DebloatWindowsItalia.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:DebloatWindowsItalia"
        mc:Ignorable="d"
        Title="Debloat" Height="763" Width="1470" Background="#FF1A2733">
    <Viewbox>
        <Grid HorizontalAlignment="Center" Width="830" Background="#FF1A2733" Height="402">
            <TextBlock TextWrapping="Wrap" Text="SOFTWARE" Foreground="#FF777777" Margin="31,54,0,329" HorizontalAlignment="Left" FontFamily="Segoe UI" Width="76" FontSize="14"/>
            <Button Content="Windows Italia" HorizontalAlignment="Left" VerticalAlignment="Top"  Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Name="Tab1A" Margin="10,11,0,0" Background="#FF1A2733" FontSize="14"/>
            <Button Content="Winget" HorizontalAlignment="Left" VerticalAlignment="Top"  Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Name="Tab2A" Margin="30,75,0,0" Background="#FF1A2733"/>
            <Button Content="     Bloatware" HorizontalAlignment="Left" VerticalAlignment="Top" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,95,0,0" Name="Tab3A" Background="#FF1A2733"/>
            <Button Content="Privacy" HorizontalAlignment="Left" VerticalAlignment="Top" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,151,0,0" Name="Tab4A" Background="#FF1A2733"/>
            <Image Height="18" Width="18" Name="Powershell" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Powershell.png" Margin="32,76,780,308"/>
            <Image Height="18" Width="18" Name="Bloatware" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Bloatware.png" Margin="31,95,781,289"/>
            <TextBlock TextWrapping="Wrap" Text="TWEAKS" Foreground="#FF777777" Margin="30,131,0,252" HorizontalAlignment="Left" FontFamily="Segoe UI" Width="76" FontSize="14"/>
            <Button Content="Utility  " HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,171,0,0" Name="Tab5A"/>
            <Button Content="   Defender" HorizontalAlignment="Left" VerticalAlignment="Center" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,0,0,0" Name="Tab6A"/>
            <Button Content="Update" HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,211,0,0" Name="Tab7A"/>
            <Button Content="       Application" HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,231,0,0" Name="Tab8A"/>
            <Button Content="System" HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,251,0,0" Name="Tab9A"/>
            <Button Content="  Explorer" HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,271,0,0" Name="Tab10A"/>
            <Button Content=" Taskbar" HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,291,0,0" x:Name="Tab11A"/>
            <TextBlock TextWrapping="Wrap" Text="SETTINGS" Foreground="#FF777777" Margin="31,328,0,55" HorizontalAlignment="Left" FontFamily="Segoe UI" Width="76" FontSize="14"/>
            <Button Content="   Repair PC" HorizontalAlignment="Left" VerticalAlignment="Top" Background="#FF1A2733" Foreground="#ffffff" BorderThickness="0,0,0,0" FontWeight="Bold" Height="20" Width="100" Margin="30,349,0,0" Name="Tab12A"/>
            <TextBlock HorizontalAlignment="Left" Margin="48,391,0,0" TextWrapping="NoWrap" Text="v 3.1.0 by @Paki94x" VerticalAlignment="Top" Foreground="#FF6A6A6A" Height="18" Width="70" FontStyle="Normal" FontWeight="Light" FontStretch="Expanded" TextTrimming="CharacterEllipsis" FontSize="8"/>
            <TextBlock HorizontalAlignment="Left" Margin="31,28,0,0" TextWrapping="Wrap" VerticalAlignment="Top" FontSize="7" Foreground="#FF777777"><Run FontStyle="Italic" Text="Seguici su Telegram @windowsitaly"/></TextBlock>
            <Image Height="18" Width="18" Name="Privacy" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Privacy.png" Margin="32,152,780,232"/>
            <Image Height="18" Width="18" Name="Utility" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Utility.png" Margin="32,172,780,212"/>
            <Image Height="20" Width="20" Name="Defender" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Defender.png" Margin="31,191,779,191"/>
            <Image Height="18" Width="18" Name="Update" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Update.png" Margin="32,213,780,171"/>
            <Image Height="18" Width="18" Name="Application" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Application.PNG" Margin="32,233,780,151"/>
            <Image Height="18" Width="18" Name="System" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/System.png" Margin="32,253,780,131"/>
            <Image Height="18" Width="18" Name="Explorer" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Explorer.png" Margin="32,273,780,111"/>
            <Image Height="18" Width="18" Name="Taskbar" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Taskbar.png" Margin="32,292,780,92"/>
            <Image Height="18" Width="18" Name="RepairPC" SnapsToDevicePixels="True" Source="https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Repair%20PC.PNG" Margin="32,350,780,34"/>

            <TabControl Margin="160,0,10,0" Grid.Column="1" Padding="-0.5" Name="TabNav" SelectedIndex="0" Background="#FF1F272E">
                <TabItem Header="EzMode" Visibility="Collapsed" Name="Tab1">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="200"/>
                            <ColumnDefinition Width="200"/>
                            <ColumnDefinition Width="250"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Margin="0,25,0,0" Grid.Column="3">
                            <TextBlock TextWrapping="Wrap" Text="Sei Indeciso su quali opzioni scegliere per ogni menu' del Debloat? Questi Tasti hanno preset pensati apposta per te" Foreground="White" TextAlignment="Center" FontSize="12" FontWeight="Bold" Margin="0,0,0,0" Width="250"/>
                            <Button Content="Clicca Qui Per Installare i Tuoi Software" Width="250" Height="50" Margin="0,15,0,25" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            
                            
                        <Button Content="Fast Startup ON" Margin= "0,0,0,7" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="200" Name="Tab1P11">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Fast Startup OFF" Margin= "0,0,0,7" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="200" Name="Tab1P12">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>

                    <TextBlock TextWrapping="Wrap" Text="Qui per scaricare il tool per creare la tua ISO di Windows Custom" Foreground="White" FontWeight="Bold" Margin="0,15,0,7" FontSize="15" TextAlignment="Center"/>

                        <Button Content="Custom ISO Windows 10" Margin= "0,5,0,7" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="200" Name="Tab1P22">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>

                        <Button Content="Custom ISO Windows 11" Margin= "0,0,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="200" Name="Tab1P23">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>


                        </StackPanel>
                        <StackPanel Margin="0,25,0,0" Grid.Column="0">
                        <TextBlock TextWrapping="Wrap" Text="Windows 10" Foreground="White" FontWeight="Bold" Margin="0,0,0,7" FontSize="15" TextAlignment="Center"/>
                            <Button Content="Bloatware" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P2">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Privacy" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P3">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Utility" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P4">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Defender" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P5">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Update" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P6">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Application" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P7">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="System" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P8">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Explorer" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P9">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Taskbar" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P10">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                        </StackPanel>

                    <StackPanel Margin="0,25,0,0" Grid.Column="1">
                        <TextBlock TextWrapping="Wrap" Text="Windows 11" Foreground="White" FontWeight="Bold" Margin="0,0,0,7" FontSize="15" TextAlignment="Center"/>
                            <Button Content="Bloatware" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P13">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Privacy" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P14">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Utility" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P15">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Defender" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P16">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Update" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P17">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Application" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P18">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="System" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P19">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Explorer" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P20">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                            <Button Content="Taskbar" Width="150" Height="30" Margin="0,7,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab1P21">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                            </Button>
                        </StackPanel>

                    </Grid>
                </TabItem>
                <TabItem Header="Winget" Visibility="Collapsed" Name="Tab2">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="110"/>
                            <ColumnDefinition Width="110"/>
                            <ColumnDefinition Width="110"/>
                            <ColumnDefinition Width="110"/>
                            <ColumnDefinition Width="110"/>
                            <ColumnDefinition Width="110"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Archiving" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="install7zip" Content="7-Zip" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installpeazip" Content="PeaZip" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwinrar" Content="WinRar" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Browser" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installfirefox" Content="Firefox" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="nstalledge" Content="Edge" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installchromium" Content="Chromium" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installchrome" Content="Chrome" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installlibrewolf" Content="LibreWolf" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installopera" Content="Opera" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwaterfox" Content="Waterfox" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installtor" Content="Tor Browser" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Image Viewer" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installfaststone" Content="FastStone" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installirfanview" Content="IrfanView" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installxnview" Content="XnView" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installimageglass" Content="ImageGlass" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installphotoviewer" Content="Photo Viewer" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Video Player" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installklite" Content="K-Lite" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installvlc" Content="VLC" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installmpc" Content="MPC" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installkodi" Content="Kodi" Margin="5,0,0,0" Foreground="White"/>
                        </StackPanel>

                        <StackPanel Grid.Column="1">
                            <Label Content="Music Player" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installfoobar2000" Content="Foobar2000" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installaimp" Content="Aimp" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwinamp" Content="WinAmp" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installspotify" Content="Spotify" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installdeezer" Content="Deezer" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Editor Text" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installvscode" Content="VS Code" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installvscodium" Content="VS Codium" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installstudiocode" Content="Studio Code" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installnotepadplusplus" Content="Notepad++" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installobsidian" Content="Obsidian" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installnotepad" Content="Notepad" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Office Editor" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installlibreoffice" Content="LibreOffice" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installwpsoffice" Content="WPS Office" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installonlyoffice" Content="Only Office" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Scripts" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installscript1" Content="Uninstall EDGE" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installscript2" Content="Clean WUCache" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installscript3" Content="Delete All Temp" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Reading" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installcalibre" Content="Calibre" Margin="5,0,0,0" Foreground="White"/>

                        </StackPanel>

                        <StackPanel Grid.Column="2">
                            <Label Content="PDF Tools" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installadobereader" Content="Adobe Reader" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installfoxit" Content="Foxit Reader" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installfoxitphantom" Content="Foxit Phantom" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installpdf24" Content="PDF24" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installpdfarranger" Content="PDF Arranger" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installsumatrapdf" Content="Sumatra PDF" Margin="5,0,0,0" Foreground="White"/>
                            

                            <Label Content="Editor I/A/V" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installaudacity" Content="Audacity" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installgimp" Content="Gimp" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installmkvtoolnix" Content="MKVToolnix" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installhandbrake" Content="Handbrake" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installmakemkv" Content="Make MKV" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installkdenlive" Content="KDEnlive" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installflstudio" Content="FL Studio" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Cloud" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installmega" Content="Mega" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installgdrive" Content="Google Drive" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installonedrive" Content="OneDrive" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installnextcloud" Content="Next Cloud" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installsyncthing" Content="Syncthing" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installdropbox" Content="Dropbox" Margin="5,0,0,0" Foreground="White"/>

                            <Button Content="Install Selected" Margin="-3,11,5,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab2P1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>

                        <StackPanel Grid.Column="3">
                        
                            <Label Content="Gaming" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installsteam" Content="Steam" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installretroarch" Content="Retroarch" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installds4windows" Content="DS4Windows" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installantimicro" Content="AntiMicro" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installheroic" Content="HeroicLauncher" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Security" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installbitwarden" Content="Bitwarden" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installbitdefender" Content="Bitdefender" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installmalwarebytes" Content="MalwareBytes" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Communication" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installthunderbird" Content="Thunderbird" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installpidgin" Content="Pidgin" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installtelegram" Content="Telegram" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwhatsapp" Content="Whatsapp" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installdiscord" Content="Discord" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installskype" Content="Skype" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installteams" Content="Teams" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installsignal" Content="Signal" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installzoom" Content="Zoom" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installmatrix" Content="Matrix" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installferdi" Content="Ferdi" Margin="5,0,0,0" Foreground="White"/>

                            <Button Content="Update ALL" Margin="0,11,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Name="Tab2P2">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>

                        <StackPanel Grid.Column="4">
                            <Label Content="Client Download" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installqbit" Content="Qbittorrent" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installidm" Content="IDM" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installxdm" Content="XDM" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installhex" Content="HexChat" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Virtualizzazione" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installvmware" Content="VMWare" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installvirtualbox" Content="Virtualbox" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Traduttori" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installdeepl" Content="DeepL" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installqbtranslate" Content="QBTranslate" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Masterizzatori" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installcdburnerxp" Content="CDBurnerXP" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installimgburn" Content="ImgBurn" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Remote Control" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installanydesk" Content="Anydesk" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installteamviewer" Content="Team Viewer" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installparsec" Content="Parsec" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="File Manager" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installopus" Content="Directory Opus" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installteracopy" Content="TeraCopy" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installtotal" Content="TotalCommand." Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installfreecommander" Content="FreeCommand." Margin="5,0,0,0" Foreground="White"/>
                        </StackPanel>

                        <StackPanel Grid.Column="5">
                            <Label Content="Microsoft" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installpowertoys" Content="PowerToys" Margin="5,-3,0,0" Foreground="White"/>
                            <CheckBox Name="installpaint" Content="Paint" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installsnippingtool" Content="Snipping Tool" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installmicrosofttodo" Content="To Do" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwindowsterminal" Content="Win Terminal" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installpowerbi" Content="Power Bi" Margin="5,0,0,0" Foreground="White"/>

                            <Label Content="Tweaks" Margin="0,2,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installmseredirect" Content="MSE Redirect" Margin="5,-0.5,0,0" Foreground="White"/>
                            <CheckBox Name="installnvcleaninstall" Content="NVCleaninstall" Margin="5,0,0,0" Foreground="White"/>


                            <Label Content="Utility" Margin="0,2,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="installautohotkey" Content="AutoHotKey" Margin="5,-1,0,0" Foreground="White"/>
                            <CheckBox Name="installsharpkey" Content="SharpKey" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installeverything" Content="Everything" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installeartrumpet" Content="Ear Trumpet" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installkdeconnect" Content="KDE Connect" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwinlaunch" Content="WinLaunch" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installwox" Content="WOX" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installputty" Content="Putty" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installobsstudio" Content="OBS Studio" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installgithub" Content="Github" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installsharex" Content="ShareX" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installfilezilla" Content="Filezilla" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="installspacedesk" Content="SpaceDesk" Margin="5,0,0,0" Foreground="White"/>
                        </StackPanel>
                    </Grid>

                </TabItem>
                <TabItem Header="Bloatware" Visibility="Collapsed" Name="Tab3">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="140"/>
                            <ColumnDefinition Width="140"/>
                            <ColumnDefinition Width="140"/>
                            <ColumnDefinition Width="200"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Bloatware" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="bcalculator" Content="Calculator" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bphotos" Content="Photos" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bcanonical" Content="Canonical" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bxboxtcui" Content="Xbox TCUI" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bxboxapp" Content="Xbox APP" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bxboxgamingoverlay" Content="Xbox Overlay" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bxboxspeech" Content="Xbox Speech" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bstickynotes" Content="Sticky Notes" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bmspaint" Content="MS Paint" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bcamera" Content="Camera" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bheifi" Content="Heifi Extension" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bscreensketch" Content="Screen Sketch" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bvp9video" Content="VP9 Extension" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwebmedia" Content="Web Extension" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwebimage" Content="Webp Extension" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwindsynth" Content="WindSynthBerry" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bmidiberry" Content="MidiBerry" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bslack" Content="Slack" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bmixedreality" Content="Mixed Reality" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bppiprojection" Content="PPI Projection" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bbingnews" Content="Bing News" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bgethelp" Content="Get Help" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bgetstarted" Content="Get Started" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bmessaging" Content="Messaging" Margin="5,0,0,0" Foreground="White"/>
                        </StackPanel>

                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="b3dviewer" Content="3D Viewer" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bofficehub" Content="Office Hub" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bsolitaire" Content="Solitaire" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bnetworkspeedtest" Content="Network Speed" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bnews" Content="News" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bofficelens" Content="Office Lens" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bonenote" Content="Onenote" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bofficesway" Content="Office Sway" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="boneconnect" Content="One Connect" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bpeople" Content="People" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bprint3d" Content="Print 3D" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bremotedesktop" Content="Remote Desktop" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bskypeapp" Content="Skype App" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bofficetodo" Content="Office To Do" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwhiteboard" Content="Whiteboard" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwindowsalarm" Content="Windows Alarm" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwindowscommunications" Content="Commmunications" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bfeedback" Content="Feedback" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bmaps" Content="Maps" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bsound" Content="Sound Record" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bzune" Content="Zune Music" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bxboxidentity" Content="Xbox Identity" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bzunevideo" Content="Zune Video" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="beclipse" Content="Eclipse" Margin="5,0,0,0" Foreground="White"/>
                        </StackPanel>

                        <StackPanel Grid.Column="2">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="blanguage" Content="Language pack" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="badobe" Content="Adobe Express" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bduolingo" Content="Duolingo" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bpandoramedia" Content="PandoraMedia" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bcandycrush" Content="Candy Crush" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bbubblewitch" Content="BubbleWitch" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwunderlist" Content="Wunderlist" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bflipboard" Content="Flipboard" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="btwitter" Content="Twitter" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bfacebook" Content="Facebook" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bspotify" Content="Spotify" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bminecraft" Content="Minecraft" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="broyalrevolt" Content="Royal Revolt" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bsway" Content="Sway" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bdolby" Content="Dolby" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="badvertising" Content="Advertising XAML" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwallet" Content="Wallet" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="byourphone" Content="Your Phone" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bedge" Content="Edge Stable" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bwinget" Content="Desktop Installer" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bstore" Content="Microsoft Store" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bui" Content="UI Libraries" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bvclibs" Content="VC Libraries" Margin="5,0,0,0" Foreground="White"/>
                            <CheckBox Name="bnet" Content=".NET" Margin="5,0,0,0" Foreground="White"/>
                        </StackPanel>
                        <StackPanel Grid.Column="3" Height="400">
                            <Label Content="" Margin="0,10,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <TextBlock TextWrapping="Wrap" Text="Bloatware is used to describe unwanted pre-installed software or bundled programs. SoftwareBloat is a process whereby successive versions of a computer program become perceptibly slower, use more memory, disk space or processing power" Foreground="#FF777777" FontWeight="Normal" Margin="10,-20,4,0" TextAlignment="Center" FontStyle="Italic" FontSize="8" HorizontalAlignment="Right" VerticalAlignment="Bottom" Height="53" Width="180"/>
                            <Button Content="Suggested Choices" Margin="10,20,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab3P1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Remove Selected" Margin="10,20,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab3P2">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Advanced Menu" Margin="10,20,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab3P4">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Reinstall ALL" Margin="10,20,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab3P3">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <TextBlock TextWrapping="Wrap" Text="Reinstall all bloatware only if you need an application that didn't install from Microsoft Store or other Methods" Foreground="#FF777777" FontWeight="Bold" Margin="10,12.5,0,0" TextAlignment="Center"/>
                        </StackPanel>
                    </Grid>
                </TabItem>
                <TabItem Header="Privacy" Visibility="Collapsed" Name="Tab4">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="250"/>
                            <ColumnDefinition Width="250"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Privacy Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="p1" Content="O e O Shutup" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p2" Content="Disable Language Options" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p3" Content="Disable Suggested Apps" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p4" Content="Disable Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p5" Content="Disable Activity History" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p6" Content="Disable Location Tracking" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p7" Content="Disable Error Reporting" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p8" Content="Disable Diagnostic Tracking" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p9" Content="Disable WAP Push Service" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p10" Content="Disable Home Group Services" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p11" Content="Disable Remote Assistance" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p12" Content="Disable Storage Check" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p13" Content="Disable Superfetch" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p14" Content="Disable Hibernation" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p15" Content="Disable Auto Manteinance" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p16" Content="Disable Reserved Storage" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p17" Content="Disable InstallService" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p18" Content="Disable Fullscreen Optimization" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p19" Content="Disable Scheduled Defrag" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p20" Content="Disable Xbox Features" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p21" Content="Disable Fast Startup" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p22" Content="Uninstall Microsoft Store" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="p23" Content="All Bandwidth" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="p24" Content="Edit Host (Lock Telemetry)" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p25" Content="Enable Language Options" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p26" Content="Enable Suggested App" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p27" Content="Enable Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p28" Content="Enable Activity History" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p29" Content="Enable Location Tracking" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p30" Content="Enable Error Reporting" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p31" Content="Enable Diagnostic Tracking" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p32" Content="Enable WAP Push Service" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p33" Content="Enable Home Group Services" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p34" Content="Enable Remote Assistance" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p35" Content="Enable Storage Check" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p36" Content="Enable Superfetch" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p37" Content="Enable Hibernation" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p38" Content="Add Keys to Registry" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p39" Content="Tweaks GameDVR" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p40" Content="Disable System Recovery" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p41" Content="Enable Fullscreen Optimization" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p42" Content="Enable Scheduled Defrag" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p43" Content="Enable Xbox Features" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p44" Content="Enable Fast Startup" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p45" Content="Install Microsoft Store" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="p46" Content="Normal Bandwidth" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <Button Content="Suggested Choices" Margin="462,-89,-393,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab4P1">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Run Selected" Margin="464,50,-393,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab4P2">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                    </Grid>
                </TabItem>
                <TabItem Header="Utility" Visibility="Collapsed" Name="Tab5">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="320"/>
                            <ColumnDefinition Width="320"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Utility Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="ut1" Content="Disable Background App Access" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut2" Content="Disable Automatic Maps Updates" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut3" Content="Disable Feedback" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut4" Content="Disable Tailored Experiences" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut5" Content="Disable Advertising ID" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut6" Content="Disable SmartScreen Filter" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut7" Content="Disable WiFi-Sense" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut8" Content="Disable Adobe Flash" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut9" Content="Disable IE First Access" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut10" Content="NTFS >260 Characters" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut11" Content="Disable Cloudstore" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut12" Content="Disable Automatic Update from Windows Store" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut13" Content="BIOS in UTC Time" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut14" Content="Disable PDF Control in Edge" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut15" Content="Add Custom Powerplan" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut16" Content="IRP Stack Size" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut17" Content="SVCHost Tweak" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut18" Content="Better SSD Use" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut19" Content="Disable UWP App Access" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut20" Content="Enable Disk Compression" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut21" Content="Disable Useless Services" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut22" Content="Disable Remote Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ut23" Content="Disable Index Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="ut24" Content="Enable Background App Access" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut25" Content="Enable Automatic Maps Updates" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut26" Content="Enable Feedback" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut27" Content="Enable Tailored Experiences" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut28" Content="Enable Advertising ID" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut29" Content="Enable SmartScreen Filter" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut30" Content="Enable WiFi-Sense" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut31" Content="Hide Seconds from Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut32" Content="Show Seconds from Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut33" Content="Disable '-Shortcut' to Name" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut34" Content="Enable '-Shortcut' to Name" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut35" Content="Disable News and Interest" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut36" Content="BIOS in Local Time" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut37" Content="Hide Shortcut Icon Arrow" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut38" Content="Show Shortcut Icon Arrow" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut39" Content="Disable Numlock after Startup" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut40" Content="Enable Numlock after Startup" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut41" Content="Disable Enhanced Pointer Precision" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut42" Content="Enable Enhanced Pointer Precision" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut43" Content="More Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut44" Content="Enable Useless Services" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut45" Content="Enable Remote Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ut46" Content="Enable UWP App Access" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <Button Content="Suggested Choices" Margin= "300,255,-234,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="130" Name="Tab5P1">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Run Selected" Margin= "300,328,-234,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="130" Name="Tab5P2">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                    </Grid>
                </TabItem>
                <TabItem Header="Defender" Visibility="Collapsed" Name="Tab6">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="320"/>
                            <ColumnDefinition Width="320"/>
                            <ColumnDefinition Width="100"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Windows Defender Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="d1" Content="Disable Controlled Folder Access" Margin="5,-3,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d2" Content="Disable Core Isolation Memory Integrity" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d3" Content="Disable Windows Defender Application Guard" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d4" Content="Hide Account Protection Warning" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d5" Content="Disable Block of Downloaded Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d6" Content="Disable Windows Script Host" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d7" Content="Disable .NET Strong Cryptography" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d8" Content="Disable Meltdown (CVE-2017-5754) Compatibility Flag" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d9" Content="Minimum UAC Level" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d10" Content="Disable Share Mapped Drives Between Users" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d11" Content="Disable Implicit Administrative Shares" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d12" Content="Disable SMB Server" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d13" Content="Disable LLMNR" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d14" Content="Set Current Network Profile to Private" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d15" Content="Set Unknown Networks Profile to Private" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d16" Content="Disable Automatic Installation of Network Devices" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d17" Content="Disable Firewall" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d18" Content="Disable Windows Defender" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d19" Content="Disable Windows Defender Cloud" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d20" Content="Disable F8 Boot Menu Options" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d21" Content="Disable NetBIOS over TCP/IP" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d22" Content="Disable Internet Connection Sharing" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d23" Content="Hide Windows Defender SysTray Icon" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="d24" Content="Disable Windows Defender Services" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="d25" Content="Enable Controlled Folder Access" Margin="5,-3,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d26" Content="Enable Core Isolation Memory Integrity" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d27" Content="Enable Windows Defender Application Guard" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d28" Content="Show Account Protection Warning" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d29" Content="Enable Block of Downloaded Files" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d30" Content="Enable Windows Script Host" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d31" Content="Enable .NET Strong Cryptography" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d32" Content="Enable Meltdown (CVE-2017-5754) Compatibility Flag" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d33" Content="Maximum UAC Level" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d34" Content="Enable Share Mapped Drives Between Users" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d35" Content="Enable Implicit Administrative Shares" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d36" Content="Enable SMB Server" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d37" Content="Enable LLMNR" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d38" Content="Set Current Network Profile to Public" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d39" Content="Set Unknown Networks Profile to Public" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d40" Content="Enable Automatic Installation of Network Devices" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d41" Content="Enable Firewall" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d42" Content="Enable Windows Defender" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d43" Content="Enable Windows Defender Cloud" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d44" Content="Enable F8 Boot Menu Options" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d45" Content="Enable NetBIOS over TCP/IP" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d46" Content="Enable Internet Connection Sharing" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d47" Content="Show Windows Defender SysTray" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="d48" Content="Enable Windows Defender Services" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <StackPanel Grid.Column="2">
                            <Label Content="" Margin="0,200,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <Button Content="Max Protection" Margin="-100,39,85,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" HorizontalAlignment="Stretch" Name="Tab6P1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Suggested Choices" Margin="-100,5,85,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" VerticalAlignment="Stretch" Name="Tab6P2">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Run Selected" Margin="-100,5,85,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab6P3">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>
                    </Grid>
                </TabItem>
                <TabItem Header="Update" Visibility="Collapsed" Name="Tab7">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="400"/>
                            <ColumnDefinition Width="200"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Windows Update Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="u1" Content="Disable Nightly Wake-Up for Automatic Maintenance" Margin="10,20,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u2" Content="Disable Windows Update Automatic Downloads" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u3" Content="Disable Updates for Other Microsoft Products" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u4" Content="Disable Malicious Software Removal Tool Offering" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u5" Content="Restrict Windows Update P2P Optimization to Local Network" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u6" Content="Disable Driver Download from Windows Update" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u7" Content="Disable Windows Update Automatic Restart" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u8" Content="Disable Update Notifications" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="u9" Content="Only Security Update" Margin="10,0,0,0" Foreground="White" Background="#FF0CBF5B"/>

                            <CheckBox Name="u10" Content="Enable Nightly Wake-Up for Automatic Maintenance" Margin="10,40,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u11" Content="Enable Windows Update Automatic Downloads" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u12" Content="Enable Updates for Other Microsoft Products" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u13" Content="Enable Malicious Software Removal Tool Offering" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u14" Content="Unrestrict Windows Update P2P Optimization to Local Network" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u15" Content="Enable Driver Download from Windows Update" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u16" Content="Enable Windows Update Automatic Restart" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u17" Content="Enable Update Notifications" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="u18" Content="Default Windows Update" Margin="10,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,60,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <Button Content="Default Settings" Margin="30,-50,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab7P1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <TextBlock TextWrapping="Wrap" Text="Default Settings for Windows Update. it removes any custom settings" Foreground="#FF777777" Margin="30,0,0,0" FontSize="8" Width="140" Height="22" TextAlignment="Center" FontStyle="Italic"/>
                            <Button Content="Security Settings" Margin="30,15,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab7P2">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <TextBlock TextWrapping="Wrap" Text="Custom settings that install only Security Updates and didn't restart the system without your consent" Foreground="#FF777777" Margin="41,5,0,0" FontSize="8" Width="140" Height="33" TextAlignment="Center" FontStyle="Italic"/>
                            <Button Content="Disable All Updates" Margin="30,15,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab7P3">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <TextBlock TextWrapping="Wrap" Text="This completely disable updates. It is Not Recommended because your system will be easier to hack and infect. Use at your risk" Foreground="#FF777777" Margin="41,5,0,0" FontSize="8" Width="140" Height="43" TextAlignment="Center" FontStyle="Italic"/>
                            <Button Content="Run Selected" Margin= "5,25,-25,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" Name="Tab7P4">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>

                        </StackPanel>
                    </Grid>
                </TabItem>

                <TabItem Header="Application" Visibility="Collapsed" Name="Tab8">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="270"/>
                            <ColumnDefinition Width="270"/>
                            <ColumnDefinition Width="200"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Application Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="a1" Content="Remove OneDrive" Margin="5,-3,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a2" Content="Disable Windows Media Player" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a3" Content="Disable Internet Explorer" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a4" Content="Disable Work Folders" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a5" Content="Disable WSL (Linux Subsystem)" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a6" Content="Disable Hyper-V" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a7" Content="Remove PhotoViewer from Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a8" Content="Remove Microsoft Print to PDF" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a9" Content="Remove Microsoft XPS Document Writer" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a10" Content="Remove Fax Printer" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a11" Content="Remove Developer Mode" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a12" Content="Remove Math Recognizer" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a13" Content="Disable Setting Sync" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a14" Content="Disable Windows Live ID Service" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a15" Content="Performance Settings FX" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>

                            <Label Content="Telemetry" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="a16" Content="Disable CCleaner Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a17" Content="Disable Office Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a18" Content="Disable Adobe Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a19" Content="Disable Dropbox Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a20" Content="Disable Google Update Service" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a21" Content="Disable Logitech Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a22" Content="Disable Vs Code Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="a23" Content="Disable Chrome Telemetry" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="a24" Content="Reinstall OneDrive" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a25" Content="Reactive Windows Media Player" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a26" Content="Reactive Internet Explorer" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a27" Content="Reactive Work Folders" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a28" Content="Reactive WSL (Linux Subsystem)" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a29" Content="Reactive Hyper-V" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a30" Content="Add PhotoViewer to Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a31" Content="Add Microsoft Print to PDF" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a32" Content="Add Microsoft XPS Document Writer" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a33" Content="Add Fax Printer" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a34" Content="Add Developer Mode" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a35" Content="Add Math Recognizer" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a36" Content="Enable NFS (Network FS)" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="a37" Content="Graphic Settings FX" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <TextBlock TextWrapping="Wrap" Text="Mostly Options disable only the Program from Control Panel because there are options that needed it" Foreground="#FF777777" Margin="50,15,9,0" TextAlignment="Center" FontSize="11" FontStyle="Italic"/>

                        </StackPanel>
                        <Button Content="Suggested Choices" Margin= "250,290,130,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" HorizontalAlignment="Stretch" Grid.ColumnSpan="2" Name="Tab8P1">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Run Selected" Margin= "450,290,130,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="40" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Name="Tab8P2">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>

                    </Grid>
                </TabItem>
                <TabItem Header="System" Visibility="Collapsed" Name="Tab9">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="320"/>
                            <ColumnDefinition Width="320"/>
                            <ColumnDefinition Width="400"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="System Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="e1" Content="Show known File Extensions" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e2" Content="Show Hidden Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e3" Content="Show Protected Operating System Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e4" Content="Show Empty Drives (With no Media)" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e5" Content="Show Folder Merge Conflicts" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e6" Content="Enable Navigation Panel Expand to Current Folder" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e7" Content="Enable Launching Folder in a Separate Process" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e8" Content="Enable Restoring Previous Folder at Logon" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e9" Content="Show Coloring of Encrypted or Compressed NTFS Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e10" Content="Enable Sharing Wizard" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e11" Content="Show Checkbox" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e12" Content="Show Sync Provider Notifications" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e13" Content="Show 'Include in Library' in Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e14" Content="Show 'Give Access to' in Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e15" Content="Show 'Share' in Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e16" Content="Enable Thumbnails" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e17" Content="Enable Creation of Thumbnail Cache Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e18" Content="Enable Creation of Thumbs.db on Network Folders" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e19" Content="Show Recycle Bin Shorcut from Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e20" Content="Show This PC Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e21" Content="Show User Folder Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e22" Content="Show Control Panel Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="e23" Content="Show Network Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="e24" Content="Hide known File Extensions" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e25" Content="Hide Hidden Files" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e26" Content="Hide Protected Operating System Files" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e27" Content="Hide Empty Drives (With no Media)" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e28" Content="Hide Folder Merge Conflicts" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e29" Content="Disable Navigation Panel Expand to Current Folder" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e30" Content="Disable Launching Folder in a Separate Process" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e31" Content="Disable Restoring Previous Folder at Logon" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e32" Content="Hide Coloring of Encrypted or Compressed NTFS Files" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e33" Content="Disable Sharing Wizard" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e34" Content="Hide Checkbox" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e35" Content="Hide Sync Provider Notifications" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e36" Content="Hide 'Include in Library' in Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e37" Content="Hide 'Give Access to' in Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e38" Content="Hide 'Share' in Context Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e39" Content="Disable Thumbnails" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e40" Content="Disable Creation of Thumbnail Cache Files" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e41" Content="Disable Creation of Thumbs.db on Network Folders" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e42" Content="Hide Recycle Bin Shorcut from Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e43" Content="Hide This PC Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e44" Content="Hide User Folder Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e45" Content="Hide Control Panel Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="e46" Content="Hide Network Shorcut on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <Button Content="Suggested" Margin= "438,256,268,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="100" Name="Tab9P1">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Run Selected" Margin= "300,328,130,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="100" Name="Tab9P2">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                    </Grid>
                </TabItem>
                <TabItem Header="Explorer" Visibility="Collapsed" Name="Tab10">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="290"/>
                            <ColumnDefinition Width="290"/>
                            <ColumnDefinition Width="400"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Explorer Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="ed1" Content="Show All Icon on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed2" Content="Show Windows Build Number on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed3" Content="Show Desktop Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed4" Content="Show Documents Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed5" Content="Show Downloads Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed6" Content="Show Music Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed7" Content="Show Pictures Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed8" Content="Show Videos Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed9" Content="Show Network Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed10" Content="Show Full Directory Path in Explorer" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed11" Content="Show All Folder in Explorer Navigation Panel" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed12" Content="Show Recent Shorcuts in Explorer" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed13" Content="Change Default Explorer view to This PC" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed14" Content="Show Quick Access in Explorer Navigation Panel" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed15" Content="Show Libraries Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed16" Content="Show Desktop Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed17" Content="Show Documents Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed18" Content="Show Downloads Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed19" Content="Show Music icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed20" Content="Show Pictures Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed21" Content="Show Videos Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="ed22" Content="Show Network Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="ed23" Content="Hide All Icon on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed24" Content="Hide Windows Build Number on Desktop" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed25" Content="Hide Desktop Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed26" Content="Hide Documents Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed27" Content="Hide Downloads Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed28" Content="Hide Music Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed29" Content="Hide Pictures Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed30" Content="Hide Videos Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed31" Content="Hide Network Icon in This PC" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed32" Content="Hide Full Directory Path in Explorer" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed33" Content="Hide All Folder in Explorer Navigation Panel" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed34" Content="Hide Recent Shorcuts in Explorer" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed35" Content="Change Default Explorer view to Quick Access" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed36" Content="Hide Quick Access in Explorer Navigation Panel" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed37" Content="Hide Libraries Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed38" Content="Hide Desktop Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed39" Content="Hide Documents Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed40" Content="Hide Downloads Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed41" Content="Hide Music icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed42" Content="Hide Pictures Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed43" Content="Hide Videos Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="ed44" Content="Hide Network Icon in Explorer Namespace" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <Button Content="Suggested Choices" Margin= "379,350,454,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="130" Name="Tab10P1">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Run Selected" Margin= "300,350,102,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="130" Name="Tab10P2">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                    </Grid>
                </TabItem>
                <TabItem Header="Taskbar" Visibility="Collapsed" Name="Tab11">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="320"/>
                            <ColumnDefinition Width="320"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Label Content="Taskbar Tweaks" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="t1" Content="Disable 'Recent Elements' in Start Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t2" Content="Disable 'Most Used' in Start Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t3" Content="Disable Windows Search in Start Menu" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t4" Content="Hide Task Icon in Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t5" Content="Hide People Icon in Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t6" Content="Transparent Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t7" Content="Show All Tray Icon" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t8" Content="Disable Action Center" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t9" Content="Disable Cortana" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t10" Content="Light Theme" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t11" Content="Disable AeroShake" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t12" Content="Task Manager, Show Details" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t13" Content="Show Details Operation Files" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t14" Content="Control Panel Icon View" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t15" Content="Disable Search for App in Store for Unknown Extensions" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t16" Content="Disable 'How do you want to open this file?' Prompt" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t17" Content="Disable Recent Files Lists" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t18" Content="Disable Clearing of Recent Files on Exit" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t19" Content="Disable Autoplay" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t21" Content="Disable Autorun for All Drives" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t22" Content="Disable Sticky Keys Prompt" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t23" Content="Disable Paint3D" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t46" Content="Disable 3d Object" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>
                            <CheckBox Name="t48" Content="Disable News and Interest" Margin="5,0,0,0" Foreground="White" Background="#FF0CBF5B"/>

                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Label Content="" Margin="0,0,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="t24" Content="Enable 'Recent Elements' in Start Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t25" Content="Enable 'Most Used' in Start Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t26" Content="Enable Windows Search in Start Menu" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t27" Content="Show Task Icon in Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t28" Content="Show People Icon in Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t29" Content="Solid Taskbar" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t30" Content="Hide All Tray Icon" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t31" Content="Enable Action Center" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t32" Content="Enable Cortana" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t33" Content="Dark Theme" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t34" Content="Enable AeroShake" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t35" Content="Task Manager, Show Details" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t36" Content="Show Details Operation Files" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t37" Content="Control Panel Categories View" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t38" Content="Enable Search for App in Store for Unknown Extensions" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t39" Content="Enable 'How do you want to open this file?' Prompt" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t40" Content="Enable Recent Files Lists" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t41" Content="Enable Clearing of Recent Files on Exit" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t42" Content="Enable Autoplay" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t44" Content="Enable Autorun for All Drives" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t45" Content="Enable Sticky Keys Prompt" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t20" Content="Treat As Internal Port" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t47" Content="Enable 3d Object" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                            <CheckBox Name="t49" Content="Enable News and Interest" Margin="5,0,0,0" Foreground="White" Background="#FFBF0C0C"/>
                        </StackPanel>
                        <Button Content="Suggested Choices" Margin= "300,255,-234,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="130" Name="Tab11P1">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                        <Button Content="Run Selected" Margin= "300,328,-234,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="130" Name="Tab11P2">
                            <Button.Background>
                                <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                    <GradientStop Color="#FF10171E" Offset="1"/>
                                    <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                </LinearGradientBrush>
                            </Button.Background>
                            <Button.Style>
                                <Style/>
                            </Button.Style>
                        </Button>
                    </Grid>
                </TabItem>
                <TabItem Header="Repair PC" Visibility="Collapsed" Name="Tab12">
                    <Grid Background="#FF1F272E">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="160"/>
                            <ColumnDefinition Width="160"/>
                            <ColumnDefinition Width="160"/>
                            <ColumnDefinition Width="160"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <Button Content="Add or Remove Programs" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Power Options" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P2">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Devices and Printers" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P3">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Multimedia / Sound" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P4">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Network Properties" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P5">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Network and Sharing" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P6">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="System Properties" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P7">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="services.msc" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P8">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="regedit.exe" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P9">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="msconfig.exe" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P10">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Component Services" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P11">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <Button Content="Device Manager" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P12">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="User Accounts" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P13">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="compmgmt.msc /s" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P14">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Color Management" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P15">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Credential Manager" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P16">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Default Programs" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P17">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Folder Options" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P18">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Taskbar and Navigation" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P19">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Display Properties" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P20">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="msinfo32.exe" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P21">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="taskschd.msc /s" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P22">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>
                        <StackPanel Grid.Column="2">
                            <Label Content="Repair PC" Margin="0,-2,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="r1" Content="CPU-Z" Margin="5,-3,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r2" Content="GPU-Z" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r3" Content="Crystal Disk Info" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r4" Content="Crystal Disk Mark" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r5" Content="HWinfo" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r6" Content="TCPView" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r7" Content="Sysinternal" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r8" Content="Process Explorer" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r9" Content="Defender Counter Stop" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r10" Content="Core Temp" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r11" Content="Speccy" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r12" Content="SUMo" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r13" Content="OCCT" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r14" Content="AIDA64" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r15" Content="Throttle Stop" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r16" Content="Autoruns" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r17" Content="Wireshark" Margin="5,-1,0,0" Foreground="White" Background="White"/>                            
                            <CheckBox Name="r18" Content="BleachBit" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r19" Content="Glary Utilities" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r20" Content="CCleaner" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r21" Content="Revo Uninstaller" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r22" Content="Bulk Crap Uninstaller" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r23" Content=".Net" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r24" Content="VC++" Margin="5,-1,0,0" Foreground="White" Background="White"/>
                                <Button Content="Install Selected" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Width="150" Name="Tab12P31">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>
                        <StackPanel Grid.Column="3">
                            <Label Content="Partition, Backup, Recovery" Margin="0,-2,0,0" FontWeight="Bold" Background="#00000000" Foreground="White"/>
                            <CheckBox Name="r25" Content="Paragon Backup e Recovery" Margin="5,-3,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r26" Content="MiniTool Partition Free" Margin="5,0,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r27" Content="EaseUS Partition Master" Margin="5,0,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r28" Content="AOMEI Partition Assistant" Margin="5,0,0,0" Foreground="White" Background="White"/>
                            <CheckBox Name="r29" Content="Recuva" Margin="5,0,0,0" Foreground="White" Background="White"/>
                            <Button Content="Verifica Licenza Windows" Margin= "0,15,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P23" Padding="1,1,1,1">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Verifica Licenza Office" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P24">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Battery Report" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P25">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Export Drivers" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P26">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Reset Connection" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P27">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Reset Microsoft Store" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P28">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="Dism" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P29">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                            <Button Content="SFC" Margin= "0,5,0,0" Foreground="White" BorderBrush="#FF777777" FontWeight="Bold" Height="30" HorizontalAlignment="Stretch" Grid.ColumnSpan="3" Width="150" Name="Tab12P30">
                                <Button.Background>
                                    <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                                        <GradientStop Color="#FF10171E" Offset="1"/>
                                        <GradientStop Color="#FF1A2733" Offset="0.257"/>
                                    </LinearGradientBrush>
                                </Button.Background>
                                <Button.Style>
                                    <Style/>
                                </Button.Style>
                            </Button>
                        </StackPanel>
                    </Grid>
                </TabItem>
            </TabControl>
        </Grid>
    </Viewbox>
</Window>
"@

$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'
    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
    [xml]$XAML = $inputXML
    #Read XAML
    
        $reader=(New-Object System.Xml.XmlNodeReader $xaml) 
    try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
    catch [System.Management.Automation.MethodInvocationException] {
        Write-Warning "We ran into a problem with the XAML code.  Check the syntax for this control..."
        write-host $error[0].Exception.Message -ForegroundColor Red
        if ($error[0].Exception.Message -like "*button*"){
            write-warning "Ensure your &lt;button in the `$inputXML does NOT have a Click=ButtonClick property.  PS can't handle this`n`n`n`n"}
    }
    catch{#if it broke some other way <img draggable="false" role="img" class="emoji" alt="😀" src="https://s0.wp.com/wp-content/mu-plugins/wpcom-smileys/twemoji/2/svg/1f600.svg">
        Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."
            }
    
    $xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
    
    Function Get-FormVariables{
    if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
    write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
    get-variable WPF*
    }
    
    Get-FormVariables

##########################################
######### Navigation Controls ############
##########################################

$WPFTab1A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $true
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab2A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $true
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab3A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $true
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab4A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $true
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab5A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $true
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab6A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $true
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab7A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $true
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab8A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $true
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab9A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $true
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab10A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $true
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab11A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $true
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab12A.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $false
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $true
})

##########################################
################# Easy ###################
##########################################

$WPFTab1P1.Add_Click({
    $WPFTabNav.Items[0].IsSelected = $false
    $WPFTabNav.Items[1].IsSelected = $true
    $WPFTabNav.Items[2].IsSelected = $false
    $WPFTabNav.Items[3].IsSelected = $false
    $WPFTabNav.Items[4].IsSelected = $false
    $WPFTabNav.Items[5].IsSelected = $false
    $WPFTabNav.Items[6].IsSelected = $false
    $WPFTabNav.Items[7].IsSelected = $false
    $WPFTabNav.Items[8].IsSelected = $false
    $WPFTabNav.Items[9].IsSelected = $false
    $WPFTabNav.Items[10].IsSelected = $false
    $WPFTabNav.Items[11].IsSelected = $false
})

$WPFTab1P2.Add_Click({

    $global:Bloatware = @(
    "Microsoft.Windows.Photos"
    "CanonicalGroupLimited.UbuntuonWindows"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MSPaint"
    "Microsoft.WindowsCamera"
    "Microsoft.HEIFImageExtension"
    "Microsoft.ScreenSketch"
    "Microsoft.VP9VideoExtensions"
    "Microsoft.WebMediaExtensions"
    "Microsoft.WebpImageExtension"
    "WindSynthBerry"
    "MIDIBerry"
    "Slack"
    "Microsoft.MixedReality.Portal"
    "Microsoft.PPIProjection"
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.RemoteDesktop"
    "Microsoft.SkypeApp"
    "Microsoft.Office.Todo.List"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "EclipseManager"
    "ActiproSoftwareLLC"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "Duolingo-LearnLanguagesforFree"
    "PandoraMediaInc"
    "CandyCrush"
    "BubbleWitch3Saga"
    "Wunderlist"
    "Flipboard"
    "Twitter"
    "Facebook"
    "Spotify"
    "Minecraft"
    "Royal Revolt"
    "Sway"
    "Dolby"
    "Microsoft.Advertising.Xaml"
    "Microsoft.Wallet"
    "Microsoft.YourPhone"
    "Microsoft.LanguageExperiencePackit-IT"
    "Microsoft.MicrosoftEdge.Stable"
    "MicrosoftCorporationII.QuickAssist"
    "MicrosoftWindows.Client.WebExperience"
    "Clipchamp.Clipchamp"
    "Microsoft.HEVCVideoExtension"
    "Microsoft.RawImageExtension"
    "Microsoft.Todos"
    "Microsoft.PowerAutomateDesktop"
)

$global:WhiteListedApps = @(
    "Microsoft.Services.Store.Engagement"
    "Microsoft.Services.Store.Engagement"
    "Microsoft.StorePurchaseApp"
    "Microsoft.WindowsStore"
    "NVIDIACorp.NVIDIAControlPanel"
    "\.NET"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Windows.ShellExperienceHost"
    "Microsoft.VCLibs*"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.WindowsCalculator"
    "PythonSoftwareFoundation.Python.3.10"
    "5319275A.WhatsAppDesktop"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Windows.ShellExperienceHost"
    "Microsoft.UI.Xaml.2.8"
    "Microsoft.UI.Xaml.2.8"
    "Microsoft.UI.Xaml.2.4"
    "Microsoft.UI.Xaml.2.4"
    "Microsoft.UI.Xaml.2.0"
    "Microsoft.UI.Xaml.2.7"
    "Microsoft.UI.Xaml.2.7"
    "Microsoft.WindowsAppRuntime.1.2"
    "Microsoft.WindowsAppRuntime.1.2"
    "Microsoft.WindowsAppRuntime.1.3-preview1"
    "Microsoft.WindowsAppRuntime.1.3-preview1"
    "Microsoft.Advertising.Xaml"
    "Microsoft.LanguageExperiencePackit-IT"
    )

#NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
$NonRemovables = Get-AppxPackage -AllUsers | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxPackage | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxProvisionedPackage -Online | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.DisplayName }
$NonRemovables = $NonRemovables | Sort-Object -Unique

if ($NonRemovables -eq $null ) {
    # the .NonRemovable property doesn't exist until version 18xx. Use a hard-coded list instead.
    #WARNING: only use exact names here - no short names or wildcards
    $NonRemovables = @(
        "1527c705-839a-4832-9118-54d4Bd6a0c89"
        "c5e2524a-ea46-4f67-841f-6a9465d9d515"
        "E2A4F912-2574-4A75-9BB0-0D023378592B"
        "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE"
        "InputApp"
        "Microsoft.AAD.BrokerPlugin"
        "Microsoft.AccountsControl"
        "Microsoft.BioEnrollment"
        "Microsoft.CredDialogHost"
        "Microsoft.ECApp"
        "Microsoft.LockApp"
        "Microsoft.MicrosoftEdgeDevToolsClient"
        "Microsoft.MicrosoftEdge"
        "Microsoft.PPIProjection"
        "Microsoft.Win32WebViewHost"
        "Microsoft.Windows.Apprep.ChxApp"
        "Microsoft.Windows.AssignedAccessLockApp"
        "Microsoft.Windows.CapturePicker"
        "Microsoft.Windows.CloudExperienceHost"
        "Microsoft.Windows.ContentDeliveryManager"
        "Microsoft.Windows.Cortana"
        "Microsoft.Windows.HolographicFirstRun"
        "Microsoft.Windows.NarratorQuickStart"
        "Microsoft.Windows.OOBENetworkCaptivePortal"
        "Microsoft.Windows.OOBENetworkConnectionFlow"
        "Microsoft.Windows.ParentalControls"
        "Microsoft.Windows.PeopleExperienceHost"
        "Microsoft.Windows.PinningConfirmationDialog"
        "Microsoft.Windows.SecHealthUI"
        "Microsoft.Windows.SecondaryTileExperience"
        "Microsoft.Windows.SecureAssessmentBrowser"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.Windows.XGpuEjectDialog"
        "Microsoft.XboxGameCallableUI"
        "Windows.CBSPreview"
        "windows.immersivecontrolpanel"
        "Windows.PrintDialog"
        "Microsoft.Services.Store.Engagement"
        "Nvidia"
        "Microsoft.WindowsStore"
        "Microsoft.StorePurchaseApp"
        "NVIDIACorp.NVIDIAControlPanel"
        "40459File-New-Project.EarTrumpet"
	    "/.NET"
	    "Microsoft.Services.Store.Engagement"
        "Microsoft.DesktopAppInstaller"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.UI.Xaml.2.8"
        "Microsoft.UI.Xaml.2.8"
        "Microsoft.UI.Xaml.2.4"
        "Microsoft.UI.Xaml.2.4"
        "Microsoft.UI.Xaml.2.0"
        "Microsoft.UI.Xaml.2.7"
        "Microsoft.UI.Xaml.2.7"
        "Microsoft.WindowsAppRuntime.1.2"
        "Microsoft.WindowsAppRuntime.1.2"
        "Microsoft.WindowsAppRuntime.1.3-preview1"
        "Microsoft.WindowsAppRuntime.1.3-preview1"

    )
}

# import library code - located relative to this script
Function dotInclude() {
    Param(
        [Parameter(Mandatory)]
        [string]$includeFile
    )
    # Look for the file in the same directory as this script
    $scriptPath = $PSScriptRoot
    if ( $PSScriptRoot -eq $null -and $psISE) {
        $scriptPath = (Split-Path -Path $psISE.CurrentFile.FullPath)
    }
    if ( test-path $scriptPath\$includeFile ) {
        # import and immediately execute the requested file
        . $scriptPath\$includeFile
    }
}

# Override built-in blacklist/whitelist with user defined lists
dotInclude 'custom-lists.ps1'

#convert to regular expression to allow for the super-useful -match operator
$global:BloatwareRegex = $global:Bloatware -join '|'
$global:WhiteListedAppsRegex = $global:WhiteListedApps -join '|'

            $ErrorActionPreference = 'SilentlyContinue'
            Function DebloatBlacklist {
                Write-Host "Removing Bloatware"
                Get-AppxPackage | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -cmatch $global:BloatwareRegex | Remove-AppxProvisionedPackage -Online
                Get-AppxPackage -AllUsers | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
            }
            DebloatBlacklist
                Function CheckDMWService {
            
                Param([switch]$Debloat)
            
                If (Get-Service dmwappushservice | Where-Object { $_.StartType -eq "Disabled" }) {
                    Set-Service dmwappushservice -StartupType Automatic
                }
            
                If (Get-Service dmwappushservice | Where-Object { $_.Status -eq "Stopped" }) {
                    Start-Service dmwappushservice
                } 
            }
            
            Function CheckInstallService {
            
                If (Get-Service InstallService | Where-Object { $_.Status -eq "Stopped" }) {  
                    Start-Service InstallService
                    Set-Service InstallService -StartupType Automatic 
                }
            }
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
Get-AppxPackage -allusers Microsoft.BingWeather | Remove-AppxPackage
            Write-Host "Done"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P3.Add_Click({
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/Iblis94/debloat3.0/main/OO.cfg" -Destination ooshutup10.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet
    Write-Host "Executed O&O Shutup with Recommended Settings"

    Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1 
    Write-Host "Disabled Language Options"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -Name "Start" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" -Name "Start" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Write-Host "Disabled Suggested Apps"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Write-Host "Disabled Telemetry"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    Write-host "Disabled Activity History"

    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    Write-host "Disabled Location Tracking"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-host "Disabled Error Reporting"

    Stop-Service "DiagTrack" -WarningAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled
    Write-host "Disabled Diagnostic Tracking"

    Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
    Set-Service "dmwappushservice" -StartupType Disabled
    Write-host "Disabled WAP Push Service"

    Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
    Set-Service "HomeGroupListener" -StartupType Disabled
    Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
    Set-Service "HomeGroupProvider" -StartupType Disabled
    Write-host "Disabled Home Group Services"

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
    Write-host "Disabled Remote Assistance"

    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
    Write-host "Disabled Storage Check" 

    Stop-Service "SysMain" -WarningAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled
    Write-host "Disabled Superfetch" 

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type dword -Value 1
    Write-host "Disabled Auto Manteinance" 

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" -Name "ShippedWithReserves" -Type dword -Value 0
    Write-host "Disabled Reserved Storage" 

    Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
    Write-host "Disabled Scheduled Defrag" 

    $ErrorActionPreference = 'SilentlyContinue'
    $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
    New-Item -Path $Bandwidth -ItemType Directory -Force
    Set-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit" -Type DWord -Value 0
    Write-host "Enabled All Bandwidth" 

    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 00000000
    Write-host "Enabled Tweaks GameDVR" 

    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 0
    Write-host "Enabled Optimization Fullscreen" 

    Write-Host "Completed"
            $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information

    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P4.Add_Click({
      
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
        Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
    }
    Write-host "Disabled Background App Access" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    Write-host "Disabled Automatic Maps Updates" 
            
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-host "Disabled Feedback" 
            
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableMmx" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    Write-host "Disabled Tailored Experiences" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    Write-host "Disabled Advertising ID" 
            
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
    Write-host "Disabled Smartscreen Filter" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
    Write-host "Disabled WiFi-Sense" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Name "DisableFlashInIE" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Name "FlashPlayerEnabled" -Type DWord -Value 0
    Write-host "Disabled Adobe Flash" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Type DWord -Value 1
    Write-host "Disabled IE First Access" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Type DWord -Value 1
    Write-host "NTFS >260 Characters" 
            
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
    If (Test-Path $CloudStore) {
        Stop-Process Explorer.exe -Force
        Remove-Item $CloudStore -Recurse -Force
        Start-Process Explorer.exe -Wait
    }
    Write-host "Disabled Cloudstore" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
    Write-host "Set BIOS UTC Time" 
            
    $NoPDF = "HKCR:\.pdf"
    $NoProgids = "HKCR:\.pdf\OpenWithProgids"
    $NoWithList = "HKCR:\.pdf\OpenWithList" 
    If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
        New-ItemProperty $NoPDF NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
        New-ItemProperty $NoPDF  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
        New-ItemProperty $NoProgids  NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
        New-ItemProperty $NoProgids  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
        New-ItemProperty $NoWithList  NoOpenWith
    }        
    If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
        New-ItemProperty $NoWithList  NoStaticDefaultVerb 
    }
        
    #Appends an underscore '_' to the Registry key for Edge
    $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    If (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
    } 
    Write-host "Disabled PDF Control in Edge" 
            
    powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-host "Custom Powerplan Installed" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
    Write-host "Set IRP Stack Size to 20" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4194304
    Write-host "Set SVChost Tweak" 
            
    fsutil behavior set DisableLastAccess 1
    fsutil behavior set EncryptPagingFile 0
    Write-host "Set Better SSD Use" 
                 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1
    Disable-NetFirewallRule -Name "RemoteDesktop*"
    Write-host "Disabled Remote Desktop" 
            
    $obj = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'"
    $indexing = $obj.IndexingEnabled
    if("$indexing" -eq $True){
        write-host "Disabling indexing of drive $Drive"
        $obj | Set-WmiInstance -Arguments @{IndexingEnabled=$False} | Out-Null
    }
    Write-host "Disabled Indexing" 
        
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
    Write-host "Disabled News and Interests" 
            
	If (!(Test-Path "HKU:")) {
		New-PSDrive -Name "HKU" -PSProvider "Registry" -Root "HKEY_USERS" | Out-Null
	}
	Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
	Add-Type -AssemblyName System.Windows.Forms
	If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
		$wsh = New-Object -ComObject WScript.Shell
		$wsh.SendKeys('{NUMLOCK}')
	}
    Write-host "Enabled NumLock after Startup" 
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P5.Add_Click({
    Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -ErrorAction SilentlyContinue
    Write-Host "Disabled Core Isolation Memory Integrity"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows Security Health\State")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Force | Out-Null
    }
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -Type DWord -Value 1
    Write-Host "Hided Account Protection Warning"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWord -Value 1
    Write-Host "Disabled Block of Downloaded Files"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -Type DWord -Value 0
    Write-Host "Disabled Windows Script Host"

    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
    Write-Host "Disabled .NET Strong Cryptography"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
    Write-Host "Minimum UAC Level"

    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -ErrorAction SilentlyContinue
    Write-Host "Disabled Share Mapped Drives Between Users"

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -Type DWord -Value 0
    Write-Host "Disabled Implicit Administrative Shares"

    Set-NetConnectionProfile -NetworkCategory Private
    Write-Host "Set Current Network Profile to Private"

    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    Write-Host "Enabled F8 Boot Menu Options"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P6.Add_Click({
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -Type DWord -Value 0
    Write-Host "Disabled Nightly Wake-Up for Automatic Maintenance"

    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Type DWord -Value 2
    }
    Write-Host "Disabled Windows Update Automatic Downloads"

    If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
    # Method used in 1507
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
    # Method used in 1511 and 1607
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 1
    } Else {
    # Method used since 1703
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
    }
    Write-Host "Restrict Windows Update P2P Optimization to Local Network"

    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -Type String -Value "cmd.exe"
    Write-Host "Disabled Windows Update Automatic Restart"

    takeown /F "$env:WinDIR\System32\MusNotification.exe"
    icacls "$env:WinDIR\System32\MusNotification.exe" /deny "$($EveryOne):(X)"
    takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
    icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "$($EveryOne):(X)"
    Write-Host "Disabled Update Notifications"

    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Only Security Update"

    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P7.Add_Click({

    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
    Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
    $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Remove OneDrive"
    
    Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Windows Media Player"
      
    Disable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Work Folders"
    
    If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
    Uninstall-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
    } Else {
    Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
    Write-Host "Disabled Hyper-V"
    
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Remove Microsoft Print to PDF"
    
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Remove Microsoft XPS Document Writer"
    
    Remove-Printer -Name "Fax" -ErrorAction SilentlyContinue
    Write-Host "Remove Fax Printer"
    
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -ErrorAction SilentlyContinue
    Write-Host "Remove Developer Mode"
    
    Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Remove-WindowsCapability -Online | Out-Null
    Write-Host "Remove Math Recognizer"
    
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "BackupPolicy" 0x3c
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "DeviceMetadataUploaded" 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "PriorLogons" 1
    $groups = @(
    "Accessibility"
    "AppSync"
    "BrowserSettings"
    "Credentials"
    "DesktopTheme"
    "Language"
    "PackageState"
    "Personalization"
    "StartLayout"
    "Windows"
    )
    foreach ($group in $groups) {
    New-FolderForced -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" "Enabled" 0
    }     
    Write-Host "Disabled Setting Sync"
    
    Stop-Process -Force -Force -Name  ccleaner.exe
    Stop-Process -Force -Force -Name  ccleaner64.exe
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HomeScreen" -Type "String" -Value 2 -Force
    Stop-Process -Force -Force -Name "IMAGENAME eq CCleaner*"
    schtasks /Change /TN "CCleaner Update" /Disable
    Get-ScheduledTask -TaskName "CCleaner Update" | Disable-ScheduledTask
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "Monitoring" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HelpImproveCCleaner" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "SystemMonitoring" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateAuto" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateCheck" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "CheckTrialOffer" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)HealthCheck" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickClean" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickCleanIpm" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)GetIpmForTrial" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdater" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdaterIpm" -Type "DWORD" -Value 0 -Force
    Write-Host "Disabled CCleaner Telemetry"
    
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableLogging" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE
    schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE
    schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    Write-Host "Disabled Office Telemetry"
    
    Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineCore" | Disable-ScheduledTask
    Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineUA" | Disable-ScheduledTask
    #schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable
    #schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable
    Write-Host "Disabled Google Update Service"
    
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Type "String" -Value "software_reporter_tool.exe" /f
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\software_reporter_tool.exe" -Name Debugger -Type "String" -Value "%windir%\System32\taskkill.exe" -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    Write-Host "Disabled Chrome Telemetry"
       
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P8.Add_Click({

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0       
    Write-Host "Showed known File Extensions"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
    Write-Host "Showed Hidden Files"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -Type DWord -Value 0
    Write-Host "Showed Folder Merge Conflicts"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -Type DWord -Value 1
    Write-Host "Enabled Restoring Previous Folder at Logon"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 1
    Write-Host "Showed Sync Provider Notifications"

    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
    Write-Host "Showed Recycle Bin Shorcut on Desktop"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
    Write-Host "Showed This PC Shorcut on Desktop"

    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -ErrorAction SilentlyContinue
    Write-Host "Disabled Navigation Panel Expand to Current Folder"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Type DWord -Value 0
    Write-Host "Disabled Sharing Wizard"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 0
    Write-Host "Hided Checkbox"

    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue    
    Write-Host "Hided 'Include in Library"

    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue    
    Write-Host "Hided 'Give Access to' in Context Menu"

    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue   
    Write-Host "Hided 'Share' in Context Menu"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P9.Add_Click({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 0
    Write-Host "Showed All Icon on Desktop"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1
    Write-Host "Showed Full Directory Path in Explorer"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
    Write-Host "Change Default Explorer view to This PC"

    Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -ErrorAction SilentlyContinue
    Write-Host "Hided Libraries Icon in Explorer Namespace"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P10.Add_Click({
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
    Write-Host "Disabled 'Recent Elements' in Start Menu"

        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -Type DWord -Value 1
    Write-Host "Disabled 'Most Used' in Start Menu"

        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name ShellFeedsTaskbarViewMode -Type DWord -Value 2
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1    
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
    Stop-Service "WSearch" -WarningAction SilentlyContinue
    Set-Service "WSearch" -StartupType Disabled
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    Write-Host "Disabled Windows Search in Start Menu"

        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Write-Host "Hided Task Icon in Taskbar"

        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
    Write-Host "Hided People Icon in Taskbar"

        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type dword -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "ForceEffectMode" -Type dword -Value 1
    Write-Host "Set Taskbar Transparent"

        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
    Write-Host "Disabled Cortana"

        $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
    Do {
    Start-Sleep -Milliseconds 100
    $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
    } Until ($preferences)
    Stop-Process $taskmgr
    $preferences.Preferences[28] = 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
    Write-Host "Set Task Manager, Show Details"

        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
    Write-Host "Set Show Details Operation Files"

        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 0
    Write-Host "Set Control Panel Icon View"

        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1
    Write-Host "Disabled Search for App in Store for Unknown Extensions"

        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1
    Write-Host "Disabled Recent Files Lists"

        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1
    Write-Host "Disabled Autoplay"

        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
    Write-Host "Disabled Autorun for All Drives"

        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
    Write-Host "Disabled Sticky Keys Prompt"

        $Paint3Dstuff = @(
    "HKCR:\SystemFileAssociations\.3mf\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.bmp\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.fbx\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.gif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jfif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpe\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpeg\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpg\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.png\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.tif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.tiff\Shell\3D Edit"
    )
    #Rename reg key to remove it, so it's revertible
    foreach ($Paint3D in $Paint3Dstuff) {
    If (Test-Path $Paint3D) {
    $rmPaint3D = $Paint3D + "_"
    Set-Item $Paint3D $rmPaint3D
    }
    }
    Write-Host "Disabled Paint3D"

        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
 If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        If (!(Test-Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
    Write-Host "Disabled 3D Object"

        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Write-Host "Set Dark Theme"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
    Write-Host "Disabled News and Interest"

    Write-Host "Removed Pinned Icon on Taskbar"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P11.Add_Click({
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 1
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P12.Add_Click({
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
    powercfg /HIBERNATE OFF 2>&1 | Out-Null
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P13.Add_Click({

    $global:Bloatware = @(
    "Microsoft.Windows.Photos"
    "CanonicalGroupLimited.UbuntuonWindows"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MSPaint"
    "Microsoft.WindowsCamera"
    "Microsoft.HEIFImageExtension"
    "Microsoft.ScreenSketch"
    "Microsoft.VP9VideoExtensions"
    "Microsoft.WebMediaExtensions"
    "Microsoft.WebpImageExtension"
    "WindSynthBerry"
    "MIDIBerry"
    "Slack"
    "Microsoft.MixedReality.Portal"
    "Microsoft.PPIProjection"
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.RemoteDesktop"
    "Microsoft.SkypeApp"
    "Microsoft.Office.Todo.List"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "EclipseManager"
    "ActiproSoftwareLLC"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "Duolingo-LearnLanguagesforFree"
    "PandoraMediaInc"
    "CandyCrush"
    "BubbleWitch3Saga"
    "Wunderlist"
    "Flipboard"
    "Twitter"
    "Facebook"
    "Spotify"
    "Minecraft"
    "Royal Revolt"
    "Sway"
    "Dolby"
    "Microsoft.Advertising.Xaml"
    "Microsoft.Wallet"
    "Microsoft.YourPhone"
    "Microsoft.LanguageExperiencePackit-IT"
    "Microsoft.MicrosoftEdge.Stable"
    "MicrosoftCorporationII.QuickAssist"
    "MicrosoftWindows.Client.WebExperience"
    "Clipchamp.Clipchamp"
    "Microsoft.HEVCVideoExtension"
    "Microsoft.RawImageExtension"
    "Microsoft.Todos"
    "Microsoft.PowerAutomateDesktop"
)

$global:WhiteListedApps = @(
    "Microsoft.Services.Store.Engagement"
    "Microsoft.Services.Store.Engagement"
    "Microsoft.StorePurchaseApp"
    "Microsoft.WindowsStore"
    "NVIDIACorp.NVIDIAControlPanel"
    "\.NET"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Windows.ShellExperienceHost"
    "Microsoft.VCLibs*"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.WindowsCalculator"
    "PythonSoftwareFoundation.Python.3.10"
    "5319275A.WhatsAppDesktop"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Windows.ShellExperienceHost"
    "Microsoft.UI.Xaml.2.8"
    "Microsoft.UI.Xaml.2.8"
    "Microsoft.UI.Xaml.2.4"
    "Microsoft.UI.Xaml.2.4"
    "Microsoft.UI.Xaml.2.0"
    "Microsoft.UI.Xaml.2.7"
    "Microsoft.UI.Xaml.2.7"
    "Microsoft.WindowsAppRuntime.1.2"
    "Microsoft.WindowsAppRuntime.1.2"
    "Microsoft.WindowsAppRuntime.1.3-preview1"
    "Microsoft.WindowsAppRuntime.1.3-preview1"
    "Microsoft.Advertising.Xaml"
    "Microsoft.LanguageExperiencePackit-IT"
    )

#NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
$NonRemovables = Get-AppxPackage -AllUsers | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxPackage | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxProvisionedPackage -Online | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.DisplayName }
$NonRemovables = $NonRemovables | Sort-Object -Unique

if ($NonRemovables -eq $null ) {
    # the .NonRemovable property doesn't exist until version 18xx. Use a hard-coded list instead.
    #WARNING: only use exact names here - no short names or wildcards
    $NonRemovables = @(
        "1527c705-839a-4832-9118-54d4Bd6a0c89"
        "c5e2524a-ea46-4f67-841f-6a9465d9d515"
        "E2A4F912-2574-4A75-9BB0-0D023378592B"
        "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE"
        "InputApp"
        "Microsoft.AAD.BrokerPlugin"
        "Microsoft.AccountsControl"
        "Microsoft.BioEnrollment"
        "Microsoft.CredDialogHost"
        "Microsoft.ECApp"
        "Microsoft.LockApp"
        "Microsoft.MicrosoftEdgeDevToolsClient"
        "Microsoft.MicrosoftEdge"
        "Microsoft.PPIProjection"
        "Microsoft.Win32WebViewHost"
        "Microsoft.Windows.Apprep.ChxApp"
        "Microsoft.Windows.AssignedAccessLockApp"
        "Microsoft.Windows.CapturePicker"
        "Microsoft.Windows.CloudExperienceHost"
        "Microsoft.Windows.ContentDeliveryManager"
        "Microsoft.Windows.Cortana"
        "Microsoft.Windows.HolographicFirstRun"
        "Microsoft.Windows.NarratorQuickStart"
        "Microsoft.Windows.OOBENetworkCaptivePortal"
        "Microsoft.Windows.OOBENetworkConnectionFlow"
        "Microsoft.Windows.ParentalControls"
        "Microsoft.Windows.PeopleExperienceHost"
        "Microsoft.Windows.PinningConfirmationDialog"
        "Microsoft.Windows.SecHealthUI"
        "Microsoft.Windows.SecondaryTileExperience"
        "Microsoft.Windows.SecureAssessmentBrowser"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.Windows.XGpuEjectDialog"
        "Microsoft.XboxGameCallableUI"
        "Windows.CBSPreview"
        "windows.immersivecontrolpanel"
        "Windows.PrintDialog"
        "Microsoft.Services.Store.Engagement"
        "Nvidia"
        "Microsoft.WindowsStore"
        "Microsoft.StorePurchaseApp"
        "NVIDIACorp.NVIDIAControlPanel"
        "40459File-New-Project.EarTrumpet"
	    "/.NET"
	    "Microsoft.Services.Store.Engagement"
        "Microsoft.DesktopAppInstaller"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.UI.Xaml.2.8"
        "Microsoft.UI.Xaml.2.8"
        "Microsoft.UI.Xaml.2.4"
        "Microsoft.UI.Xaml.2.4"
        "Microsoft.UI.Xaml.2.0"
        "Microsoft.UI.Xaml.2.7"
        "Microsoft.UI.Xaml.2.7"
        "Microsoft.WindowsAppRuntime.1.2"
        "Microsoft.WindowsAppRuntime.1.2"
        "Microsoft.WindowsAppRuntime.1.3-preview1"
        "Microsoft.WindowsAppRuntime.1.3-preview1"

    )
}

# import library code - located relative to this script
Function dotInclude() {
    Param(
        [Parameter(Mandatory)]
        [string]$includeFile
    )
    # Look for the file in the same directory as this script
    $scriptPath = $PSScriptRoot
    if ( $PSScriptRoot -eq $null -and $psISE) {
        $scriptPath = (Split-Path -Path $psISE.CurrentFile.FullPath)
    }
    if ( test-path $scriptPath\$includeFile ) {
        # import and immediately execute the requested file
        . $scriptPath\$includeFile
    }
}

# Override built-in blacklist/whitelist with user defined lists
dotInclude 'custom-lists.ps1'

#convert to regular expression to allow for the super-useful -match operator
$global:BloatwareRegex = $global:Bloatware -join '|'
$global:WhiteListedAppsRegex = $global:WhiteListedApps -join '|'

            $ErrorActionPreference = 'SilentlyContinue'
            Function DebloatBlacklist {
                Write-Host "Removing Bloatware"
                Get-AppxPackage | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -cmatch $global:BloatwareRegex | Remove-AppxProvisionedPackage -Online
                Get-AppxPackage -AllUsers | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
            }
            DebloatBlacklist
                Function CheckDMWService {
            
                Param([switch]$Debloat)
            
                If (Get-Service dmwappushservice | Where-Object { $_.StartType -eq "Disabled" }) {
                    Set-Service dmwappushservice -StartupType Automatic
                }
            
                If (Get-Service dmwappushservice | Where-Object { $_.Status -eq "Stopped" }) {
                    Start-Service dmwappushservice
                } 
            }
            
            Function CheckInstallService {
            
                If (Get-Service InstallService | Where-Object { $_.Status -eq "Stopped" }) {  
                    Start-Service InstallService
                    Set-Service InstallService -StartupType Automatic 
                }
            }
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
Get-AppxPackage -allusers Microsoft.BingWeather | Remove-AppxPackage
            Write-Host "Done"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P14.Add_Click({
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/Iblis94/debloat3.0/main/OO.cfg" -Destination ooshutup10.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet
    Write-Host "Executed O&O Shutup with Recommended Settings"

    Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1 
    Write-Host "Disabled Language Options"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -Name "Start" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" -Name "Start" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Write-Host "Disabled Suggested Apps"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Write-Host "Disabled Telemetry"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    Write-host "Disabled Activity History"

    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    Write-host "Disabled Location Tracking"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-host "Disabled Error Reporting"

    Stop-Service "DiagTrack" -WarningAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled
    Write-host "Disabled Diagnostic Tracking"

    Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
    Set-Service "dmwappushservice" -StartupType Disabled
    Write-host "Disabled WAP Push Service"

    Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
    Set-Service "HomeGroupListener" -StartupType Disabled
    Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
    Set-Service "HomeGroupProvider" -StartupType Disabled
    Write-host "Disabled Home Group Services"

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
    Write-host "Disabled Remote Assistance"

    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
    Write-host "Disabled Storage Check" 

    Stop-Service "SysMain" -WarningAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled
    Write-host "Disabled Superfetch" 

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type dword -Value 1
    Write-host "Disabled Auto Manteinance" 

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" -Name "ShippedWithReserves" -Type dword -Value 0
    Write-host "Disabled Reserved Storage" 

    Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
    Write-host "Disabled Scheduled Defrag" 

    $ErrorActionPreference = 'SilentlyContinue'
    $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
    New-Item -Path $Bandwidth -ItemType Directory -Force
    Set-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit" -Type DWord -Value 0
    Write-host "Enabled All Bandwidth" 

    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 00000000
    Write-host "Enabled Tweaks GameDVR" 

    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 0
    Write-host "Enabled Optimization Fullscreen" 

    Write-Host "Completed"
            $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information

    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P15.Add_Click({

    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
        Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
    }
    Write-host "Disabled Background App Access" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    Write-host "Disabled Automatic Maps Updates" 
            
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-host "Disabled Feedback" 
            
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableMmx" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    Write-host "Disabled Tailored Experiences" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    Write-host "Disabled Advertising ID" 
            
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
    Write-host "Disabled Smartscreen Filter" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
    Write-host "Disabled WiFi-Sense" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Name "DisableFlashInIE" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Name "FlashPlayerEnabled" -Type DWord -Value 0
    Write-host "Disabled Adobe Flash" 
            
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Type DWord -Value 1
    Write-host "Disabled IE First Access" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Type DWord -Value 1
    Write-host "NTFS >260 Characters" 
            
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
    If (Test-Path $CloudStore) {
        Stop-Process Explorer.exe -Force
        Remove-Item $CloudStore -Recurse -Force
        Start-Process Explorer.exe -Wait
    }
    Write-host "Disabled Cloudstore" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
    Write-host "Set BIOS UTC Time" 
            
    $NoPDF = "HKCR:\.pdf"
    $NoProgids = "HKCR:\.pdf\OpenWithProgids"
    $NoWithList = "HKCR:\.pdf\OpenWithList" 
    If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
        New-ItemProperty $NoPDF NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
        New-ItemProperty $NoPDF  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
        New-ItemProperty $NoProgids  NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
        New-ItemProperty $NoProgids  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
        New-ItemProperty $NoWithList  NoOpenWith
    }        
    If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
        New-ItemProperty $NoWithList  NoStaticDefaultVerb 
    }
        
    #Appends an underscore '_' to the Registry key for Edge
    $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    If (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
    } 
    Write-host "Disabled PDF Control in Edge" 
            
    powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-host "Custom Powerplan Installed" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
    Write-host "Set IRP Stack Size to 20" 
            
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4194304
    Write-host "Set SVChost Tweak" 
            
    fsutil behavior set DisableLastAccess 1
    fsutil behavior set EncryptPagingFile 0
    Write-host "Set Better SSD Use" 
                 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1
    Disable-NetFirewallRule -Name "RemoteDesktop*"
    Write-host "Disabled Remote Desktop" 
            
    $obj = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'"
    $indexing = $obj.IndexingEnabled
    if("$indexing" -eq $True){
        write-host "Disabling indexing of drive $Drive"
        $obj | Set-WmiInstance -Arguments @{IndexingEnabled=$False} | Out-Null
    }
    Write-host "Disabled Indexing" 
        
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
    Write-host "Disabled News and Interests" 
            
	If (!(Test-Path "HKU:")) {
		New-PSDrive -Name "HKU" -PSProvider "Registry" -Root "HKEY_USERS" | Out-Null
	}
	Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
	Add-Type -AssemblyName System.Windows.Forms
	If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
		$wsh = New-Object -ComObject WScript.Shell
		$wsh.SendKeys('{NUMLOCK}')
	}
    Write-host "Enabled NumLock after Startup" 
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P16.Add_Click({

    Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -ErrorAction SilentlyContinue
    Write-Host "Disabled Core Isolation Memory Integrity"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows Security Health\State")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Force | Out-Null
    }
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -Type DWord -Value 1
    Write-Host "Hided Account Protection Warning"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWord -Value 1
    Write-Host "Disabled Block of Downloaded Files"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -Type DWord -Value 0
    Write-Host "Disabled Windows Script Host"

    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
    Write-Host "Disabled .NET Strong Cryptography"

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
    Write-Host "Minimum UAC Level"

    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -ErrorAction SilentlyContinue
    Write-Host "Disabled Share Mapped Drives Between Users"

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -Type DWord -Value 0
    Write-Host "Disabled Implicit Administrative Shares"

    Set-NetConnectionProfile -NetworkCategory Private
    Write-Host "Set Current Network Profile to Private"

    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    Write-Host "Enabled F8 Boot Menu Options"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P17.Add_Click({
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -Type DWord -Value 0
    Write-Host "Disabled Nightly Wake-Up for Automatic Maintenance"

    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Type DWord -Value 2
    }
    Write-Host "Disabled Windows Update Automatic Downloads"

    If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
    # Method used in 1507
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
    # Method used in 1511 and 1607
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 1
    } Else {
    # Method used since 1703
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
    }
    Write-Host "Restrict Windows Update P2P Optimization to Local Network"

    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -Type String -Value "cmd.exe"
    Write-Host "Disabled Windows Update Automatic Restart"

    takeown /F "$env:WinDIR\System32\MusNotification.exe"
    icacls "$env:WinDIR\System32\MusNotification.exe" /deny "$($EveryOne):(X)"
    takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
    icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "$($EveryOne):(X)"
    Write-Host "Disabled Update Notifications"

    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Only Security Update"

    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P18.Add_Click({
 If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
    Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
    $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Remove OneDrive"
    
    Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Windows Media Player"
      
    Disable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Work Folders"
    
    If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
    Uninstall-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
    } Else {
    Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
    Write-Host "Disabled Hyper-V"
    
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Remove Microsoft Print to PDF"
    
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Remove Microsoft XPS Document Writer"
    
    Remove-Printer -Name "Fax" -ErrorAction SilentlyContinue
    Write-Host "Remove Fax Printer"
    
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -ErrorAction SilentlyContinue
    Write-Host "Remove Developer Mode"
    
    Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Remove-WindowsCapability -Online | Out-Null
    Write-Host "Remove Math Recognizer"
    
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "BackupPolicy" 0x3c
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "DeviceMetadataUploaded" 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "PriorLogons" 1
    $groups = @(
    "Accessibility"
    "AppSync"
    "BrowserSettings"
    "Credentials"
    "DesktopTheme"
    "Language"
    "PackageState"
    "Personalization"
    "StartLayout"
    "Windows"
    )
    foreach ($group in $groups) {
    New-FolderForced -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" "Enabled" 0
    }     
    Write-Host "Disabled Setting Sync"
    
    Stop-Process -Force -Force -Name  ccleaner.exe
    Stop-Process -Force -Force -Name  ccleaner64.exe
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HomeScreen" -Type "String" -Value 2 -Force
    Stop-Process -Force -Force -Name "IMAGENAME eq CCleaner*"
    schtasks /Change /TN "CCleaner Update" /Disable
    Get-ScheduledTask -TaskName "CCleaner Update" | Disable-ScheduledTask
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "Monitoring" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HelpImproveCCleaner" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "SystemMonitoring" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateAuto" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateCheck" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "CheckTrialOffer" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)HealthCheck" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickClean" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickCleanIpm" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)GetIpmForTrial" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdater" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdaterIpm" -Type "DWORD" -Value 0 -Force
    Write-Host "Disabled CCleaner Telemetry"
    
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableLogging" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE
    schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE
    schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    Write-Host "Disabled Office Telemetry"
    
    Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineCore" | Disable-ScheduledTask
    Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineUA" | Disable-ScheduledTask
    #schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable
    #schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable
    Write-Host "Disabled Google Update Service"
    
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Type "String" -Value "software_reporter_tool.exe" /f
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\software_reporter_tool.exe" -Name Debugger -Type "String" -Value "%windir%\System32\taskkill.exe" -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    Write-Host "Disabled Chrome Telemetry"
       
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P19.Add_Click({
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0       
    Write-Host "Showed known File Extensions"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
    Write-Host "Showed Hidden Files"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -Type DWord -Value 0
    Write-Host "Showed Folder Merge Conflicts"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -Type DWord -Value 1
    Write-Host "Enabled Restoring Previous Folder at Logon"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 1
    Write-Host "Showed Sync Provider Notifications"

    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
    Write-Host "Showed Recycle Bin Shorcut on Desktop"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
    Write-Host "Showed This PC Shorcut on Desktop"

    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -ErrorAction SilentlyContinue
    Write-Host "Disabled Navigation Panel Expand to Current Folder"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Type DWord -Value 0
    Write-Host "Disabled Sharing Wizard"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 0
    Write-Host "Hided Checkbox"

    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue    
    Write-Host "Hided 'Include in Library"

    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue    
    Write-Host "Hided 'Give Access to' in Context Menu"

    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue   
    Write-Host "Hided 'Share' in Context Menu"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P20.Add_Click({
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 0
    Write-Host "Showed All Icon on Desktop"

    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1
    Write-Host "Showed Full Directory Path in Explorer"

    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
    Write-Host "Change Default Explorer view to This PC"

    Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -ErrorAction SilentlyContinue
    Write-Host "Hided Libraries Icon in Explorer Namespace"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P21.Add_Click({
 If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
    Write-Host "Disabled 'Recent Elements' in Start Menu"

        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -Type DWord -Value 1
    Write-Host "Disabled 'Most Used' in Start Menu"

        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name ShellFeedsTaskbarViewMode -Type DWord -Value 2
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1    
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
    Stop-Service "WSearch" -WarningAction SilentlyContinue
    Set-Service "WSearch" -StartupType Disabled
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    Write-Host "Disabled Windows Search in Start Menu"

        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Write-Host "Hided Task Icon in Taskbar"

        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
    Write-Host "Hided People Icon in Taskbar"

        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type dword -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "ForceEffectMode" -Type dword -Value 1
    Write-Host "Set Taskbar Transparent"

        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
    Write-Host "Set Show Details Operation Files"

        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 0
    Write-Host "Set Control Panel Icon View"

        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1
    Write-Host "Disabled Search for App in Store for Unknown Extensions"

        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1
    Write-Host "Disabled Recent Files Lists"

        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1
    Write-Host "Disabled Autoplay"

        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
    Write-Host "Disabled Autorun for All Drives"

        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
    Write-Host "Disabled Sticky Keys Prompt"

        $Paint3Dstuff = @(
    "HKCR:\SystemFileAssociations\.3mf\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.bmp\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.fbx\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.gif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jfif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpe\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpeg\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpg\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.png\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.tif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.tiff\Shell\3D Edit"
    )
    #Rename reg key to remove it, so it's revertible
    foreach ($Paint3D in $Paint3Dstuff) {
    If (Test-Path $Paint3D) {
    $rmPaint3D = $Paint3D + "_"
    Set-Item $Paint3D $rmPaint3D
    }
    }
    Write-Host "Disabled Paint3D"

        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
 If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        If (!(Test-Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
    Write-Host "Disabled 3D Object"


        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
    Write-Host "Disabled Cortana"

        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Write-Host "Set Dark Theme"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
    Write-Host "Disabled News and Interest"
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Force | Out-Null
    }

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Name "ChatIcon" -Type DWord -Value 3
    Write-Host "Removed Pinned Icon on Taskbar"
    Write-Host "Completed"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab1P22.Add_Click({
Start-Process powershell.exe -Verb RunAs -ArgumentList "irm -Uri 'https://bit.ly/3AuBfDE' | iex  | Out-Host" -Wait -WindowStyle Maximized
})

$WPFTab1P23.Add_Click({
Start-Process powershell.exe -Verb RunAs -ArgumentList "irm -Uri 'https://bit.ly/3LieF6x' | iex  | Out-Host" -Wait -WindowStyle Maximized
})

##########################################
################ Winget ##################
##########################################

$WPFTab2P1.Add_Click({
    $wingetinstall = New-Object System.Collections.Generic.List[System.Object]
    If ( $WPFinstall7zip.IsChecked -eq $true ) { 
        $wingetinstall.Add("7zip.7zip")
        $WPFinstall7zip.IsChecked = $false
    }
    If ( $WPFinstallpeazip.IsChecked -eq $true ) { 
        $wingetinstall.Add("Giorgiotani.Peazip")
        $WPFinstallpeazip.IsChecked = $false
    }
    If ( $WPFinstallwinrar.IsChecked -eq $true ) { 
        $wingetinstall.Add("RARLab.WinRAR")
        $WPFinstallwinrar.IsChecked = $false
    }
    If ( $WPFinstallfirefox.IsChecked -eq $true ) { 
        $wingetinstall.Add("Mozilla.Firefox")
        $WPFinstallfirefox.IsChecked = $false
    }
    If ( $WPFnstalledge.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.Edge")
        $WPFnstalledge.IsChecked = $false
    }
    If ( $WPFinstallchromium.IsChecked -eq $true ) { 
        $wingetinstall.Add("eloston.ungoogled-chromium")
        $WPFinstallchromium.IsChecked = $false
    }
    If ( $WPFinstallchrome.IsChecked -eq $true ) { 
        $wingetinstall.Add("Google.Chrome")
        $WPFinstallchrome.IsChecked = $false
    }
    If ( $WPFinstalllibrewolf.IsChecked -eq $true ) { 
        $wingetinstall.Add("LibreWolf.LibreWolf")
        $WPFinstalllibrewolf.IsChecked = $false
    }
    If ( $WPFinstallopera.IsChecked -eq $true ) { 
        $wingetinstall.Add("Opera.Opera")
        $WPFinstallopera.IsChecked = $false
    }
    If ( $WPFinstallwaterfox.IsChecked -eq $true ) { 
        $wingetinstall.Add("Waterfox.Waterfox")
        $WPFinstallwaterfox.IsChecked = $false
    }
    If ( $WPFinstalltor.IsChecked -eq $true ) { 
        $wingetinstall.Add("TorProject.TorBrowser")
        $WPFinstalltor.IsChecked = $false
    }
    If ( $WPFinstallfaststone.IsChecked -eq $true ) { 
        $wingetinstall.Add("FastStone.Viewer")
        $WPFinstallfaststone.IsChecked = $false
    }
    If ( $WPFinstallirfanview.IsChecked -eq $true ) { 
        $wingetinstall.Add("IrfanSkiljan.IrfanView")
        $WPFinstallirfanview.IsChecked = $false
    }
    If ( $WPFinstallxnview.IsChecked -eq $true ) { 
        $wingetinstall.Add("XnSoft.XnView.Classic")
        $WPFinstallxnview.IsChecked = $false
    }
    If ( $WPFinstallimageglass.IsChecked -eq $true ) { 
        $wingetinstall.Add("DuongDieuPhap.ImageGlass")
        $WPFinstallimageglass.IsChecked = $false
    }
    If ( $WPFinstallphotoviewer.IsChecked -eq $true ) { 
        Start-BitsTransfer -Source "https://raw.githubusercontent.com/Iblis94/debloat3.0/main/enable_photo_viewer.reg" -Destination photo_viewer.reg
        ./photo_viewer.reg /quiet
        $WPFinstallphotoviewer.IsChecked = $false
    }
    If ( $WPFinstallklite.IsChecked -eq $true ) { 
        $wingetinstall.Add("CodecGuide.K-LiteCodecPack.Mega")
        $WPFinstallklite.IsChecked = $false
    }
    If ( $WPFinstallmpv.IsChecked -eq $true ) { 
        Start-Process powershell.exe -Verb RunAs -ArgumentList "Start-BitsTransfer -Source 'https://jztkft.dl.sourceforge.net/project/mpv.mirror/v0.34.1/v0.34.1.zip' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
        $WPFinstallmpv.IsChecked = $false
    }
    If ( $WPFinstallvlc.IsChecked -eq $true ) { 
        $wingetinstall.Add("VideoLAN.VLC")
        $WPFinstallvlc.IsChecked = $false
    }
    If ( $WPFinstallkodi.IsChecked -eq $true ) { 
        $wingetinstall.Add("XBMCFoundation.Kodi")
        $WPFinstallkodi.IsChecked = $false
    }
    If ( $WPFinstallmusicbee.IsChecked -eq $true ) { 
        Start-Process powershell.exe -Verb RunAs -ArgumentList "Start-BitsTransfer -Source 'https://mega.nz/file/sosy3TbZ#L7GxWAaCb7vzXh1qRBU_KWCtksWAu9kpIssgLIPkLmE' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
        $WPFinstallmusicbee.IsChecked = $false
    }
    If ( $WPFinstallfoobar2000.IsChecked -eq $true ) { 
        $wingetinstall.Add("PeterPawlowski.foobar2000")
        $WPFinstallfoobar2000.IsChecked = $false
    }
    If ( $WPFinstallaimp.IsChecked -eq $true ) { 
        $wingetinstall.Add("AIMP.AIMP")
        $WPFinstallaimp.IsChecked = $false
    }
    If ( $WPFinstallwinamp.IsChecked -eq $true ) { 
        $wingetinstall.Add("Radionomy.Winamp")
        $WPFinstallwinamp.IsChecked = $false
    }
    If ( $WPFinstallspotify.IsChecked -eq $true ) { 
        $wingetinstall.Add("Spotify.Spotify")
        $WPFinstallspotify.IsChecked = $false
    }
    If ( $WPFinstalldeezer.IsChecked -eq $true ) { 
        $wingetinstall.Add("Deezer.Deezer")
        $WPFinstalldeezer.IsChecked = $false
    }
    If ( $WPFinstallvscode.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.VisualStudioCode --source winget")
        $WPFinstallvscode.IsChecked = $false
    }
    If ( $WPFinstallvscodium.IsChecked -eq $true ) { 
        $wingetinstall.Add("Git.Git")
        $wingetinstall.Add("VSCodium.VSCodium")
        $WPFinstallvscodium.IsChecked = $false
    }
    If ( $WPFinstallstudiocode.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.VisualStudio.2022.Community")
        $WPFinstallstudiocode.IsChecked = $false
    }
    If ( $WPFinstallnotepadplusplus.IsChecked -eq $true ) { 
        $wingetinstall.Add("Notepad++.Notepad++")
        $WPFinstallnotepadplusplus.IsChecked = $false
    }
    If ( $WPFinstallobsidian.IsChecked -eq $true ) { 
        $wingetinstall.Add("Obsidian.Obsidian")
        $WPFinstallobsidian.IsChecked = $false
    }
    If ( $WPFinstallnotepad.IsChecked -eq $true ) { 
        $wingetinstall.Add("JackieLiu.NotepadsApp")
        $WPFinstallnotepad.IsChecked = $false
    }
    If ( $WPFinstalllibreoffice.IsChecked -eq $true ) { 
        $wingetinstall.Add("TheDocumentFoundation.LibreOffice")
        $WPFinstalllibreoffice.IsChecked = $false
    }
    If ( $WPFinstallwpsoffice.IsChecked -eq $true ) { 
        $wingetinstall.Add("Kingsoft.WPSOffice")
        $WPFinstallwpsoffice.IsChecked = $false
    }
    If ( $WPFinstallonlyoffice.IsChecked -eq $true ) { 
        $wingetinstall.Add("ONLYOFFICE.DesktopEditors")
        $WPFinstallonlyoffice.IsChecked = $false
    }
    If ( $WPFinstallonenote.IsChecked -eq $true ) { 
        Start-Process powershell.exe -Verb RunAs -ArgumentList "Start-BitsTransfer -Source 'https://go.microsoft.com/fwlink/?linkid=2110341' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
        $WPFinstallonenote.IsChecked = $false
    }
    If ( $WPFinstallcalibre.IsChecked -eq $true ) { 
        $wingetinstall.Add("calibre.calibre")
        $WPFinstallcalibre.IsChecked = $false
    }
    If ( $WPFinstalladobereader.IsChecked -eq $true ) { 
        $wingetinstall.Add("Adobe.Acrobat.Reader.64-bit")
        $WPFinstalladobereader.IsChecked = $false
    }
    If ( $WPFinstallmakemkv.IsChecked -eq $true ) { 
        $wingetinstall.Add("GuinpinSoft.MakeMKV")
        $WPFinstallmakemkv.IsChecked = $false
    }
    If ( $WPFinstallfoxit.IsChecked -eq $true ) { 
        $wingetinstall.Add("Foxit.FoxitReader")
        $WPFinstallfoxit.IsChecked = $false
    }
    If ( $WPFinstallfoxitphantom.IsChecked -eq $true ) { 
        $wingetinstall.Add("Foxit.PhantomPDF")
        $WPFinstallfoxitphantom.IsChecked = $false
    }
    If ( $WPFinstallpdf24.IsChecked -eq $true ) { 
        $wingetinstall.Add("geeksoftwareGmbH.PDF24Creator")
        $WPFinstallpdf24.IsChecked = $false
    }
    If ( $WPFinstallscript1.IsChecked -eq $true ) { 
        Start-Process powershell.exe -ArgumentList "Start-BitsTransfer -Source 'https://raw.githubusercontent.com/Kakihara73/Uninstall-new-EDGE/main/Uninstall_newEDGE.cmd' -Destination Uninstall_newEDGE.cmd" -Wait -WindowStyle Maximized
        ./Uninstall_newEDGE.cmd /quiet
        $WPFinstallscript3.IsChecked = $false
    }
    If ( $WPFinstallscript2.IsChecked -eq $true ) { 
        Start-Process powershell.exe -ArgumentList "Start-BitsTransfer -Source 'https://raw.githubusercontent.com/Kakihara73/cleanWUcache/main/cleanWUcache.cmd' -Destination cleanWUcache.cmd" -Wait -WindowStyle Maximized
        ./cleanWUcache.cmd /quiet
        $WPFinstallscript3.IsChecked = $false
    }
    If ( $WPFinstallscript3.IsChecked -eq $true ) { 
        Start-Process powershell.exe -ArgumentList "Start-BitsTransfer -Source 'https://raw.githubusercontent.com/Kakihara73/Delete-ALL-Temp/main/DELALLTEMP.cmd' -Destination DELALLTEMP.cmd" -Wait -WindowStyle Maximized
        ./DELALLTEMP.cmd /quiet
        $WPFinstallscript3.IsChecked = $false
    }
    If ( $WPFinstallpdfarranger.IsChecked -eq $true ) { 
        $wingetinstall.Add("PDFArranger.PDFArranger")
        $WPFinstallpdfarranger.IsChecked = $false
    }
    If ( $WPFinstallsumatrapdf.IsChecked -eq $true ) { 
        $wingetinstall.Add("SumatraPDF.SumatraPDF")
        $WPFinstallsumatrapdf.IsChecked = $false
    }
    If ( $WPFinstallgimp.IsChecked -eq $true ) { 
        $wingetinstall.Add("GIMP.GIMP")
        $WPFinstallgimp.IsChecked = $false
    }
    If ( $WPFinstallmega.IsChecked -eq $true ) { 
        $wingetinstall.Add("Mega.MEGASync")
        $WPFinstallmega.IsChecked = $false
    }
    If ( $WPFinstallgdrive.IsChecked -eq $true ) { 
        $wingetinstall.Add("Google.Drive")
        $WPFinstallgdrive.IsChecked = $false
    }
    If ( $WPFinstallonedrive.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.OneDrive.Internal.Fast")
        $WPFinstallonedrive.IsChecked = $false
    }
    If ( $WPFinstallnextcloud.IsChecked -eq $true ) { 
        $wingetinstall.Add("Nextcloud.NextcloudDesktop")
        $WPFinstallnextcloud.IsChecked = $false
    }
    If ( $WPFinstallsyncthing.IsChecked -eq $true ) { 
        $wingetinstall.Add("SyncTrayzor.SyncTrayzor")
        $WPFinstallsyncthing.IsChecked = $false
    }
    If ( $WPFinstalldropbox.IsChecked -eq $true ) { 
        $wingetinstall.Add("Dropbox.Dropbox")
        $WPFinstalldropbox.IsChecked = $false
    }
    If ( $WPFinstallqbit.IsChecked -eq $true ) { 
        $wingetinstall.Add("qBittorrent.qBittorrent")
        $WPFinstallqbit.IsChecked = $false
    }
    If ( $WPFinstallheroic.IsChecked -eq $true ) { 
        $wingetinstall.Add("HeroicGamesLauncher.HeroicGamesLauncher")
        $WPFinstallheroic.IsChecked = $false
    }
    If ( $WPFinstallidm.IsChecked -eq $true ) { 
        $wingetinstall.Add("Tonec.InternetDownloadManager")
        $WPFinstallidm.IsChecked = $false
    }
    If ( $WPFinstallxdm.IsChecked -eq $true ) { 
        $wingetinstall.Add("subhra74.XtremeDownloadManager")
        $WPFinstallxdm.IsChecked = $false
    }
    If ( $WPFinstallhex.IsChecked -eq $true ) { 
        $wingetinstall.Add("HexChat.HexChat")
        $WPFinstallhex.IsChecked = $false
    }
    If ( $WPFinstallaudacity.IsChecked -eq $true ) { 
        $wingetinstall.Add("Audacity.Audacity")
        $WPFinstallaudacity.IsChecked = $false
    }
    If ( $WPFinstallmkvtoolnix.IsChecked -eq $true ) { 
        $wingetinstall.Add("MKVToolNix.MKVToolNix")
        $WPFinstallmkvtoolnix.IsChecked = $false
    }
    If ( $WPFinstallhandbrake.IsChecked -eq $true ) { 
        $wingetinstall.Add("HandBrake.HandBrake")
        $wingetinstall.Add("Microsoft.DotNet.Runtime.6")
        $wingetinstall.Add("Microsoft.DotNet.DesktopRuntime.6")
        $WPFinstallhandbrake.IsChecked = $false
    }
    If ( $WPFinstallkdenlive.IsChecked -eq $true ) { 
        $wingetinstall.Add("KDE.Kdenlive")
        $WPFinstallkdenlive.IsChecked = $false
    }
    If ( $WPFinstallflstudio.IsChecked -eq $true ) { 
        $wingetinstall.Add("ImageLine.FLStudio")
        $WPFinstallflstudio.IsChecked = $false
    }
    If ( $WPFinstallbitwarden.IsChecked -eq $true ) { 
        $wingetinstall.Add("Bitwarden.Bitwarden")
        $WPFinstallbitwarden.IsChecked = $false
    }
    If ( $WPFinstallbitdefender.IsChecked -eq $true ) { 
        $wingetinstall.Add("Bitdefender.Bitdefender")
        $WPFinstallbitdefender.IsChecked = $false
    }
    If ( $WPFinstallmalwarebytes.IsChecked -eq $true ) { 
        $wingetinstall.Add("Malwarebytes.Malwarebytes")
        $WPFinstallmalwarebytes.IsChecked = $false
    }
    If ( $WPFinstallthunderbird.IsChecked -eq $true ) { 
        $wingetinstall.Add("Mozilla.Thunderbird")
        $WPFinstallthunderbird.IsChecked = $false
    }
    If ( $WPFinstallpidgin.IsChecked -eq $true ) { 
        $wingetinstall.Add("Pidgin.Pidgin")
        $WPFinstallpidgin.IsChecked = $false
    }
    If ( $WPFinstalltelegram.IsChecked -eq $true ) { 
        $wingetinstall.Add("Telegram.TelegramDesktop")
        $WPFinstalltelegram.IsChecked = $false
    }
    If ( $WPFinstallwhatsapp.IsChecked -eq $true ) { 
        $wingetinstall.Add("WhatsApp.WhatsApp")
        $WPFinstallwhatsapp.IsChecked = $false
    }
    If ( $WPFinstalldiscord.IsChecked -eq $true ) { 
        $wingetinstall.Add("Discord.Discord")
        $WPFinstalldiscord.IsChecked = $false
    }
    If ( $WPFinstallskype.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.Skype")
        $WPFinstallskype.IsChecked = $false
    }
    If ( $WPFinstallteams.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.Teams")
        $WPFinstallteams.IsChecked = $false
    }
    If ( $WPFinstallsignal.IsChecked -eq $true ) { 
        $wingetinstall.Add("OpenWhisperSystems.Signal")
        $WPFinstallsignal.IsChecked = $false
    }
    If ( $WPFinstallzoom.IsChecked -eq $true ) { 
        $wingetinstall.Add("Zoom.Zoom")
        $WPFinstallzoom.IsChecked = $false
    }
    If ( $WPFinstallmatrix.IsChecked -eq $true ) { 
        $wingetinstall.Add("Element.Element")
        $WPFinstallmatrix.IsChecked = $false
    }
    If ( $WPFinstallferdi.IsChecked -eq $true ) { 
        $wingetinstall.Add("AmineMouafik.Ferdi")
        $WPFinstallferdi.IsChecked = $false
    }
    If ( $WPFinstallsteam.IsChecked -eq $true ) { 
        $wingetinstall.Add("Valve.Steam")
        $WPFinstallsteam.IsChecked = $false
    }
    If ( $WPFinstallretroarch.IsChecked -eq $true ) { 
        Start-BitsTransfer -Source "https://buildbot.libretro.com/nightly/windows/x86_64/RetroArch-Win64-setup.exe" -Destination RetroArch-Win64-setup.exe
    ./RetroArch-Win64-setup.exe /quiet
        $WPFinstallretroarch.IsChecked = $false
    }
    If ( $WPFinstallds4windows.IsChecked -eq $true ) { 
        Start-Process powershell.exe -ArgumentList "Start-BitsTransfer -Source 'https://github.com/Ryochan7/DS4Windows/archive/refs/heads/jay.zip' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
        $WPFinstallds4windows.IsChecked = $false
    }
    If ( $WPFinstallantimicro.IsChecked -eq $true ) { 
        $wingetinstall.Add("AntiMicro.AntiMicro")
        $WPFinstallantimicro.IsChecked = $false
    }
    If ( $WPFinstallvmware.IsChecked -eq $true ) { 
        $wingetinstall.Add("VMware.WorkstationPlayer")
        $WPFinstallvirtualbox.IsChecked = $false
    }
    If ( $WPFinstalldeepl.IsChecked -eq $true ) { 
        $wingetinstall.Add("DeepL.DeepL")
        $WPFinstalldeepl.IsChecked = $false
    }
    If ( $WPFinstallqbtranslate.IsChecked -eq $true ) { 
        $wingetinstall.Add("QuestSoft.QTranslate")
        $WPFinstallqbtranslate.IsChecked = $false
    }
    If ( $WPFinstallcdburnerxp.IsChecked -eq $true ) { 
        $wingetinstall.Add("Canneverbe.CDBurnerXP")
        $WPFinstallcdburnerxp.IsChecked = $false
    }
    If ( $WPFinstallimgburn.IsChecked -eq $true ) { 
        $wingetinstall.Add("LIGHTNINGUK.ImgBurn")
        $WPFinstallimgburn.IsChecked = $false
    }
    If ( $WPFinstallanydesk.IsChecked -eq $true ) { 
        $wingetinstall.Add("AnyDeskSoftwareGmbH.AnyDesk")
        $WPFinstallanydesk.IsChecked = $false
    }
    If ( $WPFinstallteamviewer.IsChecked -eq $true ) { 
        $wingetinstall.Add("TeamViewer.TeamViewer")
        $WPFinstallteamviewer.IsChecked = $false
    }
    If ( $WPFinstallparsec.IsChecked -eq $true ) { 
        $wingetinstall.Add("Parsec.Parsec")
        $WPFinstallparsec.IsChecked = $false
    }
    If ( $WPFinstallopus.IsChecked -eq $true ) { 
        $wingetinstall.Add("GPSoftware.DirectoryOpus")
        $WPFinstallopus.IsChecked = $false
    }
    If ( $WPFinstallteracopy.IsChecked -eq $true ) { 
        $wingetinstall.Add("CodeSector.TeraCopy")
        $WPFinstallteracopy.IsChecked = $false
    }
    If ( $WPFinstallmpc.IsChecked -eq $true ) { 
        $wingetinstall.Add("clsid2.mpc-hc")
        $WPFinstallmpc.IsChecked = $false
    }
    If ( $WPFinstallfreecommander.IsChecked -eq $true ) { 
        $wingetinstall.Add("MarekJasinski.FreeCommanderXE")
        $WPFinstallfreecommander.IsChecked = $false
    }
    If ( $WPFinstallpowertoys.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.PowerToys")
        $WPFinstallpowertoys.IsChecked = $false
    }
    If ( $WPFinstalltotal.IsChecked -eq $true ) { 
        $wingetinstall.Add("Ghisler.TotalCommander")
        $WPFinstalltotal.IsChecked = $false
    }
    If ( $WPFinstallsnippingtool.IsChecked -eq $true ) { 
        $wingetinstall.Add("Mathpix.MathpixSnippingTool")
        $WPFinstallsnippingtool.IsChecked = $false
    }
    If ( $WPFinstallmicrosofttodo.IsChecked -eq $true ) { 
        $wingetinstall.Add("Hitencent.JisuTodo")
        $WPFinstallmicrosofttodo.IsChecked = $false
    }
    If ( $WPFinstallwindowsterminal.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.WindowsTerminal.Preview")
        $WPFinstallwindowsterminal.IsChecked = $false
    }
    If ( $WPFinstallpowerbi.IsChecked -eq $true ) { 
        $wingetinstall.Add("Microsoft.PowerBI")
        $WPFinstallpowerbi.IsChecked = $false
    }
    If ( $WPFinstallmseredirect.IsChecked -eq $true ) { 
        $wingetinstall.Add("rcmaehl.MSEdgeRedirect")
        $WPFinstallmseredirect.IsChecked = $false
    }
    If ( $WPFinstallnvcleaninstall.IsChecked -eq $true ) { 
        $wingetinstall.Add("TechPowerUp.NVCleanstall")
        $WPFinstallnvcleaninstall.IsChecked = $false
    }
    If ( $WPFinstallautohotkey.IsChecked -eq $true ) { 
        $wingetinstall.Add("Lexikos.AutoHotkey")
        $WPFinstallautohotkey.IsChecked = $false
    }
    If ( $WPFinstallsharpkey.IsChecked -eq $true ) { 
        $wingetinstall.Add("RandyRants.SharpKeys")
        $WPFinstallsharpkey.IsChecked = $false
    }
    If ( $WPFinstalleverything.IsChecked -eq $true ) { 
        $wingetinstall.Add("voidtools.Everything --source winget")
        $WPFinstalleverything.IsChecked = $false
    }
    If ( $WPFinstalleartrumpet.IsChecked -eq $true ) { 
        $wingetinstall.Add("File-New-Project.EarTrumpet")
        $WPFinstalleartrumpet.IsChecked = $false
    }
    If ( $WPFinstallkdeconnect.IsChecked -eq $true ) { 
        $wingetinstall.Add("KDE.KDEConnect")
        $WPFinstallkdeconnect.IsChecked = $false
    }
    If ( $WPFinstallwinlaunch.IsChecked -eq $true ) { 
        Start-Process powershell.exe -Verb RunAs -ArgumentList "Start-BitsTransfer -Source 'https://kumisystems.dl.sourceforge.net/project/winlaunch/Setup.exe' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
        $WPFinstallwinlaunch.IsChecked = $false
    }
    If ( $WPFinstallwox.IsChecked -eq $true ) { 
        $wingetinstall.Add("Wox.Wox")
        $WPFinstallwox.IsChecked = $false
    }
    If ( $WPFinstallputty.IsChecked -eq $true ) { 
        $wingetinstall.Add("PuTTY.PuTTY")
        $WPFinstallputty.IsChecked = $false
    }
    If ( $WPFinstallobsstudio.IsChecked -eq $true ) { 
        $wingetinstall.Add("OBSProject.OBSStudio")
        $WPFinstallobsstudio.IsChecked = $false
    }
    If ( $WPFinstallgithub.IsChecked -eq $true ) { 
        $wingetinstall.Add("Git.Git")
        $wingetinstall.Add("GitHub.GitHubDesktop")
        $WPFinstallgithub.IsChecked = $false
    }
    If ( $WPFinstallsharex.IsChecked -eq $true ) { 
        $wingetinstall.Add("ShareX.ShareX")
        $WPFinstallsharex.IsChecked = $false
    }
    If ( $WPFinstallfilezilla.IsChecked -eq $true ) { 
        $wingetinstall.Add("TimKosse.FileZilla.Client")
        $WPFinstallfilezilla.IsChecked = $false
    }
    If ( $WPFinstallspacedesk.IsChecked -eq $true ) { 
        $wingetinstall.Add("Datronicsoft.SpacedeskDriver.Client")
        $WPFinstallspacedesk.IsChecked = $false
    }

 

    $wingetinstall.ToArray()
    $wingetResult = New-Object System.Collections.Generic.List[System.Object]
    foreach ( $node in $wingetinstall )
    {
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-command winget install -e --accept-source-agreements --accept-package-agreements --silent $node | Out-Host" -Wait -WindowStyle Maximized
        $wingetResult.Add("$node`n")
    }
    $wingetResult.ToArray()
    $wingetResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Installed "
    $Messageboxbody = ($wingetResult)
    $MessageIcon = [System.Windows.MessageBoxImage]::Information

    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)

})

$WPFTab2P2.Add_Click({
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-command winget upgrade --all  | Out-Host" -Wait -WindowStyle Maximized
    
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Upgraded All "
    $Messageboxbody = ("Done")
    $MessageIcon = [System.Windows.MessageBoxImage]::Information

    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Bloatware #################
##########################################

$WPFTab3P1.Add_Click({
    $WPFbcalculator.IsChecked = $true
    $WPFbphotos.IsChecked = $true
    $WPFbcanonical.IsChecked = $true
    $WPFbxboxtcui.IsChecked = $true
    $WPFbxboxapp.IsChecked = $true
    $WPFbxboxgamingoverlay.IsChecked = $true
    $WPFbxboxspeech.IsChecked = $true
    $WPFbstickynotes.IsChecked = $true
    $WPFbmspaint.IsChecked = $true
    $WPFbcamera.IsChecked = $true
    $WPFbheifi.IsChecked = $true
    $WPFbscreensketch.IsChecked = $true
    $WPFbvp9video.IsChecked = $true
    $WPFbwebmedia.IsChecked = $true
    $WPFbwebimage.IsChecked = $true
    $WPFbwindsynth.IsChecked = $true
    $WPFbmidiberry.IsChecked = $true
    $WPFbslack.IsChecked = $true
    $WPFbmixedreality.IsChecked = $true
    $WPFbppiprojection.IsChecked = $true
    $WPFbbingnews.IsChecked = $true
    $WPFbgethelp.IsChecked = $true
    $WPFbgetstarted.IsChecked = $true
    $WPFbmessaging.IsChecked = $true
    $WPFb3dviewer.IsChecked = $true
    $WPFbofficehub.IsChecked = $true
    $WPFbsolitaire.IsChecked = $true
    $WPFbnetworkspeedtest.IsChecked = $true
    $WPFbnews.IsChecked = $true
    $WPFbofficelens.IsChecked = $true
    $WPFbonenote.IsChecked = $true
    $WPFbofficesway.IsChecked = $true
    $WPFboneconnect.IsChecked = $true
    $WPFbpeople.IsChecked = $true
    $WPFbprint3d.IsChecked = $true
    $WPFbremotedesktop.IsChecked = $true
    $WPFbskypeapp.IsChecked = $true
    $WPFbofficetodo.IsChecked = $true
    $WPFbwhiteboard.IsChecked = $true
    $WPFbwindowsalarm.IsChecked = $true
    $WPFbwindowscommunications.IsChecked = $true
    $WPFbfeedback.IsChecked = $true
    $WPFbmaps.IsChecked = $true
    $WPFbsound.IsChecked = $true
    $WPFbzune.IsChecked = $true
    $WPFbxboxidentity.IsChecked = $false
    $WPFbzunevideo.IsChecked = $true
    $WPFbeclipse.IsChecked = $true
    $WPFblanguage.IsChecked = $true
    $WPFbadobe.IsChecked = $true
    $WPFbduolingo.IsChecked = $true
    $WPFbpandoramedia.IsChecked = $true
    $WPFbcandycrush.IsChecked = $true
    $WPFbbubblewitch.IsChecked = $true
    $WPFbwunderlist.IsChecked = $true
    $WPFbflipboard.IsChecked = $true
    $WPFbtwitter.IsChecked = $true
    $WPFbfacebook.IsChecked = $true
    $WPFbspotify.IsChecked = $true
    $WPFbminecraft.IsChecked = $true
    $WPFbroyalrevolt.IsChecked = $true
    $WPFbsway.IsChecked = $true
    $WPFbdolby.IsChecked = $true
    $WPFbadvertising.IsChecked = $true
    $WPFbwallet.IsChecked = $true
    $WPFbyourphone.IsChecked = $true
    $WPFbedge.IsChecked = $true
    $WPFbwinget.IsChecked = $false
    $WPFbstore.IsChecked = $false
    $WPFbui.IsChecked = $false
    $WPFbvclibs.IsChecked = $false
    $WPFbnet.IsChecked = $false
})

$WPFTab3P2.Add_Click({
    If ( $WPFbcalculator.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsCalculator | Remove-AppxPackage
    $WPFbcalculator.IsChecked = $false
    }
    If ( $WPFbphotos.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Windows.Photos | Remove-AppxPackage
    $WPFbphotos.IsChecked = $false
    }
    If ( $WPFbcanonical.IsChecked -eq $true ) {
    Get-AppxPackage -allusers CanonicalGroupLimited.UbuntuonWindows | Remove-AppxPackage
    $WPFbcanonical.IsChecked = $false
    }
    If ( $WPFbxboxtcui.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Xbox.TCUI | Remove-AppxPackage
    $WPFbxboxtcui.IsChecked = $false
    }
    If ( $WPFbxboxapp.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.XboxApp | Remove-AppxPackage
    $WPFbxboxapp.IsChecked = $false
    }
    If ( $WPFbxboxgamingoverlay.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.XboxGameOverlay | Remove-AppxPackage
    Get-AppxPackage -allusers Microsoft.XboxGamingOverlay | Remove-AppxPackage
    $WPFbxboxgamingoverlay.IsChecked = $false
    }
    If ( $WPFbxboxspeech.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage
    $WPFbxboxspeech.IsChecked = $false
    }
    If ( $WPFbstickynotes.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
    $WPFbstickynotes.IsChecked = $false
    }
    If ( $WPFbmspaint.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.MSPaint | Remove-AppxPackage
    $WPFbmspaint.IsChecked = $false
    }
    If ( $WPFbcamera.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsCamera | Remove-AppxPackage
    $WPFbcamera.IsChecked = $false
    }
    If ( $WPFbheifi.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.HEIFImageExtension | Remove-AppxPackage
    $WPFbheifi.IsChecked = $false
    }
    If ( $WPFbscreensketch.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.ScreenSketch | Remove-AppxPackage
    $WPFbscreensketch.IsChecked = $false
    }
    If ( $WPFbvp9video.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.VP9VideoExtensions | Remove-AppxPackage
    $WPFbvp9video.IsChecked = $false
    }
    If ( $WPFbwebmedia.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WebMediaExtensions | Remove-AppxPackage
    $WPFbwebmedia.IsChecked = $false
    }
    If ( $WPFbwebimage.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WebpImageExtension | Remove-AppxPackage
    $WPFbwebimage.IsChecked = $false
    }
    If ( $WPFbwindsynth.IsChecked -eq $true ) {
    Get-AppxPackage -allusers WindSynthBerry | Remove-AppxPackage
    $WPFbwindsynth.IsChecked = $false
    }
    If ( $WPFbmidiberry.IsChecked -eq $true ) {
    Get-AppxPackage -allusers MIDIBerry | Remove-AppxPackage
    $WPFbmidiberry.IsChecked = $false
    }
    If ( $WPFbslack.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Slack | Remove-AppxPackage
    $WPFbslack.IsChecked = $false
    }
    If ( $WPFbmixedreality.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.MixedReality.Portal | Remove-AppxPackage
    $WPFbmixedreality.IsChecked = $false
    }
    If ( $WPFbppiprojection.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.PPIProjection | Remove-AppxPackage
    $WPFbppiprojection.IsChecked = $false
    }
    If ( $WPFbbingnews.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.BingNews | Remove-AppxPackage
    $WPFbbingnews.IsChecked = $false
    }
    If ( $WPFbgethelp.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.GetHelp | Remove-AppxPackage
    $WPFbgethelp.IsChecked = $false
    }
    If ( $WPFbgetstarted.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Getstarted | Remove-AppxPackage
    $WPFbgetstarted.IsChecked = $false
    }
    If ( $WPFbmessaging.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Messaging | Remove-AppxPackage
    $WPFbmessaging.IsChecked = $false
    }
    If ( $WPFb3dviewer.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Microsoft3DViewer | Remove-AppxPackage
    $WPFb3dviewer.IsChecked = $false
    }
    If ( $WPFbofficehub.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
    $WPFbofficehub.IsChecked = $false
    }
    If ( $WPFbsolitaire.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
    $WPFbsolitaire.IsChecked = $false
    }
    If ( $WPFbnetworkspeedtest.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.NetworkSpeedTest | Remove-AppxPackage
    $WPFbnetworkspeedtest.IsChecked = $false
    }
    If ( $WPFbnews.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.News | Remove-AppxPackage
    $WPFbnews.IsChecked = $false
    }
    If ( $WPFbofficelens.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Office.Lens | Remove-AppxPackage
    $WPFbofficelens.IsChecked = $false
    }
    If ( $WPFbonenote.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Office.OneNote | Remove-AppxPackage
    $WPFbonenote.IsChecked = $false
    }
    If ( $WPFbofficesway.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Office.Sway | Remove-AppxPackage
    $WPFbofficesway.IsChecked = $false
    }
    If ( $WPFboneconnect.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.OneConnect | Remove-AppxPackage
    $WPFboneconnect.IsChecked = $false
    }
    If ( $WPFbpeople.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.People | Remove-AppxPackage
    $WPFbpeople.IsChecked = $false
    }
    If ( $WPFbprint3d.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Print3D | Remove-AppxPackage
    $WPFbprint3d.IsChecked = $false
    }
    If ( $WPFbremotedesktop.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.RemoteDesktop | Remove-AppxPackage
    $WPFbremotedesktop.IsChecked = $false
    }
    If ( $WPFbskypeapp.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.SkypeApp | Remove-AppxPackage
    $WPFbskypeapp.IsChecked = $false
    }
    If ( $WPFbofficetodo.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Office.Todo.List | Remove-AppxPackage
    $WPFbofficetodo.IsChecked = $false
    }
    If ( $WPFbwhiteboard.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Whiteboard | Remove-AppxPackage
    $WPFbwhiteboard.IsChecked = $false
    }
    If ( $WPFbwindowsalarm.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsAlarms | Remove-AppxPackage
    $WPFbwindowsalarm.IsChecked = $false
    }
    If ( $WPFbwindowscommunications.IsChecked -eq $true ) {
    Get-AppxPackage -allusers microsoft.windowscommunicationsapps | Remove-AppxPackage
    $WPFbwindowscommunications.IsChecked = $false
    }
    If ( $WPFbfeedback.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsFeedbackHub | Remove-AppxPackage
    $WPFbfeedback.IsChecked = $false
    }
    If ( $WPFbmaps.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsMaps | Remove-AppxPackage
    $WPFbmaps.IsChecked = $false
    }
    If ( $WPFbsound.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsSoundRecorder | Remove-AppxPackage
    $WPFbsound.IsChecked = $false
    }
    If ( $WPFbzune.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.ZuneMusic | Remove-AppxPackage
    $WPFbzune.IsChecked = $false
    }
    If ( $WPFbxboxidentity.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.XboxIdentityProvider | Remove-AppxPackage
    $WPFbxboxidentity.IsChecked = $false
    }
    If ( $WPFbzunevideo.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.ZuneVideo | Remove-AppxPackage
    $WPFbzunevideo.IsChecked = $false
    }
    If ( $WPFbeclipse.IsChecked -eq $true ) {
    Get-AppxPackage -allusers EclipseManager | Remove-AppxPackage
    $WPFbeclipse.IsChecked = $false
    }
    If ( $WPFblanguage.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.LanguageExperiencePackit-IT | Remove-AppxPackage
    $WPFblanguage.IsChecked = $false
    }
    If ( $WPFbadobe.IsChecked -eq $true ) {
    Get-AppxPackage -allusers AdobeSystemsIncorporated.AdobePhotoshopExpress | Remove-AppxPackage
    $WPFbadobe.IsChecked = $false
    }
    If ( $WPFbduolingo.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Duolingo-LearnLanguagesforFree | Remove-AppxPackage
    $WPFbduolingo.IsChecked = $false
    }
    If ( $WPFbpandoramedia.IsChecked -eq $true ) {
    Get-AppxPackage -allusers PandoraMediaInc | Remove-AppxPackage
    $WPFbpandoramedia.IsChecked = $false
    }
    If ( $WPFbcandycrush.IsChecked -eq $true ) {
    Get-AppxPackage -allusers CandyCrush | Remove-AppxPackage
    $WPFbcandycrush.IsChecked = $false
    }
    If ( $WPFbbubblewitch.IsChecked -eq $true ) {
    Get-AppxPackage -allusers BubbleWitch3Saga | Remove-AppxPackage
    $WPFbbubblewitch.IsChecked = $false
    }
    If ( $WPFbwunderlist.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Wunderlist | Remove-AppxPackage
    $WPFbwunderlist.IsChecked = $false
    }
    If ( $WPFbflipboard.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Flipboard | Remove-AppxPackage
    $WPFbflipboard.IsChecked = $false
    }
    If ( $WPFbtwitter.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Twitter | Remove-AppxPackage
    $WPFbtwitter.IsChecked = $false
    }
    If ( $WPFbfacebook.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Facebook | Remove-AppxPackage
    $WPFbfacebook.IsChecked = $false
    }
    If ( $WPFbspotify.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Spotify | Remove-AppxPackage
    $WPFbspotify.IsChecked = $false
    }
    If ( $WPFbminecraft.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Minecraft | Remove-AppxPackage
    $WPFbminecraft.IsChecked = $false
    }
    If ( $WPFbroyalrevolt.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Royal Revolt | Remove-AppxPackage
    $WPFbroyalrevolt.IsChecked = $false
    }
    If ( $WPFbsway.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Sway | Remove-AppxPackage
    $WPFbsway.IsChecked = $false
    }
    If ( $WPFbdolby.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Dolby | Remove-AppxPackage
    $WPFbdolby.IsChecked = $false
    }
    If ( $WPFbadvertising.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Advertising.Xaml | Remove-AppxPackage
    $WPFbadvertising.IsChecked = $false
    }
    If ( $WPFbwallet.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.Wallet | Remove-AppxPackage
    $WPFbwallet.IsChecked = $false
    }
    If ( $WPFbyourphone.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.YourPhone | Remove-AppxPackage
    $WPFbyourphone.IsChecked = $false
    }
    If ( $WPFbedge.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.MicrosoftEdge.Stable | Remove-AppxPackage
    $WPFbedge.IsChecked = $false
    }
    If ( $WPFbwinget.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.DesktopAppInstaller | Remove-AppxPackage Get-AppxPackage -allusers Microsoft.Winget.Source | Remove-AppxPackage
    $WPFbwinget.IsChecked = $false
    }
    If ( $WPFbstore.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.WindowsStore | Remove-AppxPackage
    Get-AppxPackage -allusers Microsoft.Services.Store.Engagement | Remove-AppxPackage
    Get-AppxPackage -allusers Microsoft.StorePurchaseApp | Remove-AppxPackage
    $WPFbstore.IsChecked = $false
    }
    If ( $WPFbui.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.UI.Xaml.2.0 | Remove-AppxPackage
    Get-AppxPackage -allusers Microsoft.UI.Xaml.2.4 | Remove-AppxPackage
    Get-AppxPackage -allusers Microsoft.UI.Xaml.2.7 | Remove-AppxPackage
    $WPFbui.IsChecked = $false
    }
    If ( $WPFbvclibs.IsChecked -eq $true ) {
    Get-AppxPackage -allusers Microsoft.VCLibs.140.00.UWPDesktop | Remove-AppxPackage
    Get-AppxPackage -allusers Microsoft.VCLibs.140.00 | Remove-AppxPackage
    $WPFbvclibs.IsChecked = $false
    }
    If ( $WPFbnet.IsChecked -eq $true ) {
    Get-AppxPackage -allusers \.NET | Remove-AppxPackage
    $WPFbnet.IsChecked = $false
    }
    Write-Host "All Selected Bloatware are removed successfully"
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab3P4.Add_Click({

    #This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.

$ErrorActionPreference = 'SilentlyContinue'

$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
$Ask = 'Do you want to run this as an Administrator?

        Select "Yes" to Run as an Administrator

        Select "No" to not run this as an Administrator
        
        Select "Cancel" to stop the script.'

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    $Prompt = [System.Windows.MessageBox]::Show($Ask, "Run as an Administrator or not?", $Button, $ErrorIco) 
    Switch ($Prompt) {
        #This will debloat Windows 10
        Yes {
            Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
            Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
            Exit
        }
        No {
            Break
        }
    }
}

$global:Bloatware = @(
    "Microsoft.Windows.Photos"
    "CanonicalGroupLimited.UbuntuonWindows"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MSPaint"
    "Microsoft.WindowsCamera"
    "Microsoft.HEIFImageExtension"
    "Microsoft.ScreenSketch"
    "Microsoft.VP9VideoExtensions"
    "Microsoft.WebMediaExtensions"
    "Microsoft.WebpImageExtension"
    "WindSynthBerry"
    "MIDIBerry"
    "Slack"
    "Microsoft.MixedReality.Portal"
    "Microsoft.PPIProjection"
    "Microsoft.BingNews"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.OneNote"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.RemoteDesktop"
    "Microsoft.SkypeApp"
    "Microsoft.Office.Todo.List"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "EclipseManager"
    "ActiproSoftwareLLC"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "Duolingo-LearnLanguagesforFree"
    "PandoraMediaInc"
    "CandyCrush"
    "BubbleWitch3Saga"
    "Wunderlist"
    "Flipboard"
    "Twitter"
    "Facebook"
    "Spotify"
    "Minecraft"
    "Royal Revolt"
    "Sway"
    "Dolby"
    "Microsoft.Advertising.Xaml"
    "Microsoft.Wallet"
    "Microsoft.YourPhone"
    "Microsoft.LanguageExperiencePackit-IT"
    "Microsoft.MicrosoftEdge.Stable"
    "MicrosoftCorporationII.QuickAssist"
    "MicrosoftWindows.Client.WebExperience"
    "Clipchamp.Clipchamp"
    "Microsoft.HEVCVideoExtension"
    "Microsoft.RawImageExtension"
    "Microsoft.Todos"
    "Microsoft.PowerAutomateDesktop"
)

$global:WhiteListedApps = @(
    "Microsoft.Services.Store.Engagement"
    "Microsoft.Services.Store.Engagement"
    "Microsoft.StorePurchaseApp"
    "Microsoft.WindowsStore"
    "NVIDIACorp.NVIDIAControlPanel"
    "\.NET"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Windows.ShellExperienceHost"
    "Microsoft.VCLibs*"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.WindowsCalculator"
    "PythonSoftwareFoundation.Python.3.10"
    "5319275A.WhatsAppDesktop"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Windows.ShellExperienceHost"
    "Microsoft.UI.Xaml.2.8"
    "Microsoft.UI.Xaml.2.8"
    "Microsoft.UI.Xaml.2.4"
    "Microsoft.UI.Xaml.2.4"
    "Microsoft.UI.Xaml.2.0"
    "Microsoft.UI.Xaml.2.7"
    "Microsoft.UI.Xaml.2.7"
    "Microsoft.WindowsAppRuntime.1.2"
    "Microsoft.WindowsAppRuntime.1.2"
    "Microsoft.WindowsAppRuntime.1.3-preview1"
    "Microsoft.WindowsAppRuntime.1.3-preview1"
    "Microsoft.Advertising.Xaml"
    "Microsoft.LanguageExperiencePackit-IT"
    )

#NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
$NonRemovables = Get-AppxPackage -AllUsers | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxPackage | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.Name }
$NonRemovables += Get-AppxProvisionedPackage -Online | Where-Object { $_.NonRemovable -eq $true } | ForEach { $_.DisplayName }
$NonRemovables = $NonRemovables | Sort-Object -Unique

if ($NonRemovables -eq $null ) {
    # the .NonRemovable property doesn't exist until version 18xx. Use a hard-coded list instead.
    #WARNING: only use exact names here - no short names or wildcards
    $NonRemovables = @(
        "1527c705-839a-4832-9118-54d4Bd6a0c89"
        "c5e2524a-ea46-4f67-841f-6a9465d9d515"
        "E2A4F912-2574-4A75-9BB0-0D023378592B"
        "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE"
        "InputApp"
        "Microsoft.AAD.BrokerPlugin"
        "Microsoft.AccountsControl"
        "Microsoft.BioEnrollment"
        "Microsoft.CredDialogHost"
        "Microsoft.ECApp"
        "Microsoft.LockApp"
        "Microsoft.MicrosoftEdgeDevToolsClient"
        "Microsoft.MicrosoftEdge"
        "Microsoft.PPIProjection"
        "Microsoft.Win32WebViewHost"
        "Microsoft.Windows.Apprep.ChxApp"
        "Microsoft.Windows.AssignedAccessLockApp"
        "Microsoft.Windows.CapturePicker"
        "Microsoft.Windows.CloudExperienceHost"
        "Microsoft.Windows.ContentDeliveryManager"
        "Microsoft.Windows.Cortana"
        "Microsoft.Windows.HolographicFirstRun"
        "Microsoft.Windows.NarratorQuickStart"
        "Microsoft.Windows.OOBENetworkCaptivePortal"
        "Microsoft.Windows.OOBENetworkConnectionFlow"
        "Microsoft.Windows.ParentalControls"
        "Microsoft.Windows.PeopleExperienceHost"
        "Microsoft.Windows.PinningConfirmationDialog"
        "Microsoft.Windows.SecHealthUI"
        "Microsoft.Windows.SecondaryTileExperience"
        "Microsoft.Windows.SecureAssessmentBrowser"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.Windows.XGpuEjectDialog"
        "Microsoft.XboxGameCallableUI"
        "Windows.CBSPreview"
        "windows.immersivecontrolpanel"
        "Windows.PrintDialog"
        "Microsoft.Services.Store.Engagement"
        "Nvidia"
        "Microsoft.WindowsStore"
        "Microsoft.StorePurchaseApp"
        "NVIDIACorp.NVIDIAControlPanel"
        "40459File-New-Project.EarTrumpet"
	    "/.NET"
	    "Microsoft.Services.Store.Engagement"
        "Microsoft.DesktopAppInstaller"
        "Microsoft.Windows.ShellExperienceHost"
        "Microsoft.UI.Xaml.2.8"
        "Microsoft.UI.Xaml.2.8"
        "Microsoft.UI.Xaml.2.4"
        "Microsoft.UI.Xaml.2.4"
        "Microsoft.UI.Xaml.2.0"
        "Microsoft.UI.Xaml.2.7"
        "Microsoft.UI.Xaml.2.7"
        "Microsoft.WindowsAppRuntime.1.2"
        "Microsoft.WindowsAppRuntime.1.2"
        "Microsoft.WindowsAppRuntime.1.3-preview1"
        "Microsoft.WindowsAppRuntime.1.3-preview1"

    )
}

# import library code - located relative to this script
Function dotInclude() {
    Param(
        [Parameter(Mandatory)]
        [string]$includeFile
    )
    # Look for the file in the same directory as this script
    $scriptPath = $PSScriptRoot
    if ( $PSScriptRoot -eq $null -and $psISE) {
        $scriptPath = (Split-Path -Path $psISE.CurrentFile.FullPath)
    }
    if ( test-path $scriptPath\$includeFile ) {
        # import and immediately execute the requested file
        . $scriptPath\$includeFile
    }
}

# Override built-in blacklist/whitelist with user defined lists
dotInclude 'custom-lists.ps1'

#convert to regular expression to allow for the super-useful -match operator
$global:BloatwareRegex = $global:Bloatware -join '|'
$global:WhiteListedAppsRegex = $global:WhiteListedApps -join '|'


    $1CustomizeForm                  = New-Object System.Windows.Forms.Form
    $1CustomizeForm.ClientSize       = New-Object System.Drawing.Point(800,1000)
    $1CustomizeForm.StartPosition    = 'CenterScreen'
    $1CustomizeForm.FormBorderStyle  = 'FixedSingle'
    $1CustomizeForm.MinimizeBox      = $false
    $1CustomizeForm.MaximizeBox      = $true
    $1CustomizeForm.ShowIcon         = $false
    $1CustomizeForm.Text             = "Rimozione Bloatware"
    $1CustomizeForm.TopMost          = $false
    $1CustomizeForm.AutoScroll       = $true
    $1CustomizeForm.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#FF1A2733")

    $ListPanel                     = New-Object system.Windows.Forms.Panel
    $ListPanel.height              = 900
    $ListPanel.width               = 790
    $ListPanel.Anchor              = 'top,right,left'
    $ListPanel.location            = New-Object System.Drawing.Point(15,15)
    $ListPanel.AutoScroll          = $true
    $ListPanel.BackColor           = [System.Drawing.ColorTranslator]::FromHtml("#FF1F272E")

    $1Button1                       = New-Object System.Windows.Forms.Button
    $1Button1.FlatStyle             = 'Flat'
    $1Button1.Text                  = "Save Your Choices"
    $1Button1.width                 = 285
    $1Button1.height                = 50
    $1Button1.Location              = New-Object System.Drawing.Point(10, 935)
    $1Button1.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $1Button1.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $1Button2                       = New-Object System.Windows.Forms.Button
    $1Button2.FlatStyle             = 'Flat'
    $1Button2.Text                  = "Remove Selected Bloatware"
    $1Button2.width                 = 285
    $1Button2.height                = 50
    $1Button2.Location              = New-Object System.Drawing.Point(505, 935)
    $1Button2.Font                  = New-Object System.Drawing.Font('Consolas',9)
    $1Button2.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#7f9ebb")

    $1CustomizeForm.controls.AddRange(@($1Button1,$1Button2,$ListPanel))

    $1Button1.Add_Click( {
           # $ErrorActionPreference = 'SilentlyContinue'

            '$global:WhiteListedApps = @(' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Encoding utf8
            @($ListPanel.controls) | ForEach {
                if ($_ -is [System.Windows.Forms.CheckBox] -and $_.Enabled -and !$_.Checked) {
                    "    ""$( $_.Text )""" | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8
                }
            }
            ')' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8

            '$global:Bloatware = @(' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8
            @($ListPanel.controls) | ForEach {
                if ($_ -is [System.Windows.Forms.CheckBox] -and $_.Enabled -and $_.Checked) {
                    "    ""$($_.Text)""" | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8
                }
            }
            ')' | Out-File -FilePath $PSScriptRoot\custom-lists.ps1 -Append -Encoding utf8

            #Over-ride the white/blacklist with the newly saved custom list
            dotInclude custom-lists.ps1

            #convert to regular expression to allow for the super-useful -match operator
            $global:BloatwareRegex = $global:Bloatware -join '|'
            $global:WhiteListedAppsRegex = $global:WhiteListedApps -join '|'
        })

        $1Button2.Add_Click({ 
            $ErrorActionPreference = 'SilentlyContinue'
            Function DebloatBlacklist {
                Write-Host "Removing Bloatware"
                Get-AppxPackage | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
                Get-AppxProvisionedPackage -Online | Where-Object DisplayName -cmatch $global:BloatwareRegex | Remove-AppxProvisionedPackage -Online
                Get-AppxPackage -AllUsers | Where-Object Name -cmatch $global:BloatwareRegex | Remove-AppxPackage
            }
            DebloatBlacklist
                Function CheckDMWService {
            
                Param([switch]$Debloat)
            
                If (Get-Service dmwappushservice | Where-Object { $_.StartType -eq "Disabled" }) {
                    Set-Service dmwappushservice -StartupType Automatic
                }
            
                If (Get-Service dmwappushservice | Where-Object { $_.Status -eq "Stopped" }) {
                    Start-Service dmwappushservice
                } 
            }
            
            Function CheckInstallService {
            
                If (Get-Service InstallService | Where-Object { $_.Status -eq "Stopped" }) {  
                    Start-Service InstallService
                    Set-Service InstallService -StartupType Automatic 
                }
            }
            Write-Host "Done"
            })
    

    Function AddAppToCustomizeForm() {
        Param(
            [Parameter(Mandatory)]
            [int] $position,
            [Parameter(Mandatory)]
            [string] $appName,
            [Parameter(Mandatory)]
            [bool] $enabled,
            [Parameter(Mandatory)]
            [bool] $checked,
            [Parameter(Mandatory)]
            [bool] $autocheck,

            [string] $notes
        )

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(-10, (2 + $position * 25))
        $label.Text = $notes
        $label.Font = New-Object System.Drawing.Font('Consolas',8)
        $label.Width = 260
        $label.Height = 27
        $Label.TextAlign = [System.Drawing.ContentAlignment]::TopRight
        $label.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#888888")
        $ListPanel.controls.AddRange(@($label))

        $Checkbox = New-Object System.Windows.Forms.CheckBox
        $Checkbox.Text = $appName
        $CheckBox.Font = New-Object System.Drawing.Font('Consolas',8)
        $CheckBox.FlatStyle = 'Flat'
        $CheckBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
        $Checkbox.Location = New-Object System.Drawing.Point(268, (0 + $position * 25))
        $Checkbox.Autosize = 1;
        $Checkbox.Checked = $checked
        $Checkbox.Enabled = $enabled
        $CheckBox.AutoCheck = $autocheck
        $ListPanel.controls.AddRange(@($CheckBox))
    }


    $Installed = @( (Get-AppxPackage).Name )
    $Online = @( (Get-AppxProvisionedPackage -Online).DisplayName )
    $AllUsers = @( (Get-AppxPackage -AllUsers).Name )
    [int]$checkboxCounter = 0
    
    ForEach ( $item in $global:WhiteListedApps ) {
        $string = ""
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { $string += " NonRemovables " }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { $string += " Blacklist " }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { $string += "Installed" }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { $string += "" }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += "" }
        AddAppToCustomizeForm $checkboxCounter $item $true $false $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $global:Bloatware ) {
        $string = ""
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { $string += " NonRemovables " }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { $string += "Whitelist " }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { $string += "Installed" }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { $string += "" }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += "" }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $AllUsers ) {
        $string = ""
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { continue }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { continue }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { continue }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { $string += " Installed" }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += "" }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $Installed ) {
        $string = "Installed"
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { continue }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { continue }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { continue }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { continue }
        if ( $null -notmatch $Online -and $Online -cmatch $item) { $string += "" }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    ForEach ( $item in $Online ) {
        $string = ""
        if ( $null -notmatch $NonRemovables -and $NonRemovables -cmatch $item ) { continue }
        if ( $null -notmatch $global:WhiteListedAppsRegex -and $item -cmatch $global:WhiteListedAppsRegex ) { continue }
        if ( $null -notmatch $global:BloatwareRegex -and $item -cmatch $global:BloatwareRegex ) { continue }
        if ( $null -notmatch $Installed -and $Installed -cmatch $item) { continue }
        if ( $null -notmatch $AllUsers -and $AllUsers -cmatch $item) { continue }
        AddAppToCustomizeForm $checkboxCounter $item $true $true $true $string
        ++$checkboxCounter
    }
    [void]$1CustomizeForm.ShowDialog()

})

$WPFTab3P3.Add_Click({
    Start-Process powershell.exe -Verb RunAs -ArgumentList "Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”" -Wait -WindowStyle Maximized
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############### Privacy ##################
##########################################

$WPFTab4P1.Add_Click({
    $WPFp1.IsChecked = $true
    $WPFp2.IsChecked = $true
    $WPFp3.IsChecked = $true
    $WPFp4.IsChecked = $true
    $WPFp5.IsChecked = $true
    $WPFp6.IsChecked = $true
    $WPFp7.IsChecked = $true
    $WPFp8.IsChecked = $true
    $WPFp9.IsChecked = $true
    $WPFp10.IsChecked = $true
    $WPFp11.IsChecked = $true
    $WPFp12.IsChecked = $true
    $WPFp13.IsChecked = $true
    $WPFp14.IsChecked = $false
    $WPFp15.IsChecked = $true
    $WPFp16.IsChecked = $true
    $WPFp17.IsChecked = $false
    $WPFp18.IsChecked = $false
    $WPFp19.IsChecked = $true
    $WPFp20.IsChecked = $false
    $WPFp21.IsChecked = $false
    $WPFp22.IsChecked = $false
    $WPFp23.IsChecked = $true
    $WPFp24.IsChecked = $false
    $WPFp25.IsChecked = $false
    $WPFp26.IsChecked = $false
    $WPFp27.IsChecked = $false
    $WPFp28.IsChecked = $false
    $WPFp29.IsChecked = $false
    $WPFp30.IsChecked = $false
    $WPFp31.IsChecked = $false
    $WPFp32.IsChecked = $false
    $WPFp33.IsChecked = $false
    $WPFp34.IsChecked = $false
    $WPFp35.IsChecked = $false
    $WPFp36.IsChecked = $false
    $WPFp37.IsChecked = $false
    $WPFp38.IsChecked = $false
    $WPFp39.IsChecked = $true
    $WPFp40.IsChecked = $false
    $WPFp41.IsChecked = $true
    $WPFp42.IsChecked = $false
    $WPFp43.IsChecked = $false
    $WPFp44.IsChecked = $false
    $WPFp45.IsChecked = $false
    $WPFp46.IsChecked = $false

})

$WPFTab4P2.Add_Click({
        If ( $WPFp1.IsChecked -eq $true ) {
    Import-Module BitsTransfer
    Start-BitsTransfer -Source "https://raw.githubusercontent.com/Iblis94/debloat3.0/main/OO.cfg" -Destination ooshutup10.cfg
    Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    ./OOSU10.exe ooshutup10.cfg /quiet
    Write-Host "Executed O&O Shutup with Recommended Settings"
    $WPFp1.IsChecked = $false
    }
        If ( $WPFp2.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1 
    Write-Host "Disabled Language Options"
    $WPFp2.IsChecked = $false
    }
        If ( $WPFp3.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -Name "Start" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" -Name "Start" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
    Write-Host "Disabled Suggested Apps"
    $WPFp3.IsChecked = $false
    }
        If ( $WPFp4.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    Write-Host "Disabled Telemetry"
    $WPFp4.IsChecked = $false
    }
        If ( $WPFp5.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    Write-host "Disabled Activity History"
    $WPFp5.IsChecked = $false
    }
        If ( $WPFp6.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0
    Write-host "Disabled Location Tracking"
    $WPFp6.IsChecked = $false
    }
        If ( $WPFp7.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-host "Disabled Error Reporting"
    $WPFp7.IsChecked = $false
    }
        If ( $WPFp8.IsChecked -eq $true ) {
    Stop-Service "DiagTrack" -WarningAction SilentlyContinue
    Set-Service "DiagTrack" -StartupType Disabled
    Write-host "Disabled Diagnostic Tracking"
    $WPFp8.IsChecked = $false
    }
        If ( $WPFp9.IsChecked -eq $true ) {
    Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
    Set-Service "dmwappushservice" -StartupType Disabled
    Write-host "Disabled WAP Push Service"
    $WPFp9.IsChecked = $false
    }
        If ( $WPFp10.IsChecked -eq $true ) {
    Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
    Set-Service "HomeGroupListener" -StartupType Disabled
    Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
    Set-Service "HomeGroupProvider" -StartupType Disabled
    Write-host "Disabled Home Group Services"
    $WPFp10.IsChecked = $false
    }
        If ( $WPFp11.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0
    Write-host "Disabled Remote Assistance"
    $WPFp11.IsChecked = $false
    }
        If ( $WPFp12.IsChecked -eq $true ) {
    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue
    Write-host "Disabled Storage Check" 
    $WPFp12.IsChecked = $false
    }
        If ( $WPFp13.IsChecked -eq $true ) {
    Stop-Service "SysMain" -WarningAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled
    Write-host "Disabled Superfetch" 
    $WPFp13.IsChecked = $false
    }
        If ( $WPFp14.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
    powercfg /HIBERNATE OFF 2>&1 | Out-Null
    Write-host "Disabled Hibernation" 
    $WPFp14.IsChecked = $false
    }
        If ( $WPFp15.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "MaintenanceDisabled" -Type dword -Value 1
    Write-host "Disabled Auto Manteinance" 
    $WPFp15.IsChecked = $false
    }
        If ( $WPFp16.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" -Name "ShippedWithReserves" -Type dword -Value 0
    Write-host "Disabled Reserved Storage" 
    $WPFp16.IsChecked = $false
    }
        If ( $WPFp17.IsChecked -eq $true ) {
    Stop-Service InstallService
    Set-Service InstallService -StartupType Disabled
    Write-host "Disabled InstallService" 
    $WPFp17.IsChecked = $false
    }
        If ( $WPFp18.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Type DWord -Value 2
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 2
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 1
    Write-host "Disabled Fullscreen Optimization" 
    $WPFp18.IsChecked = $false
    }
        If ( $WPFp19.IsChecked -eq $true ) {
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
    Write-host "Disabled Scheduled Defrag" 
    $WPFp19.IsChecked = $false
    }
        If ( $WPFp20.IsChecked -eq $true ) {
    Get-AppxPackage "Microsoft.XboxApp" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.XboxIdentityProvider" | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Type DWord -Value 0
    Write-host "Disabled Xbox Features" 
    $WPFp20.IsChecked = $false
    }
        If ( $WPFp21.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
    Write-host "Disabled Fast Startup" 
    $WPFp21.IsChecked = $false
    }
        If ( $WPFp22.IsChecked -eq $true ) {
                        Get-AppxPackage "Microsoft.DesktopAppInstaller" | Remove-AppxPackage
            Get-AppxPackage "Microsoft.WindowsStore" | Remove-AppxPackage
    Write-host "Uninstalled Microsoft Store" 
    $WPFp22.IsChecked = $false
    }
        If ( $WPFp23.IsChecked -eq $true ) {
    $ErrorActionPreference = 'SilentlyContinue'
    $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
    New-Item -Path $Bandwidth -ItemType Directory -Force
    Set-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit" -Type DWord -Value 0
    Write-host "Enabled All Bandwidth" 
    $WPFp23.IsChecked = $false
    }
        If ( $WPFp24.IsChecked -eq $true ) {
    $hosts_file = "$env:systemroot\System32\drivers\etc\hosts"
    $domains = @(
        "184-86-53-99.deploy.static.akamaitechnologies.com"
        "a-0001.a-msedge.net"
        "a-0002.a-msedge.net"
        "a-0003.a-msedge.net"
        "a-0004.a-msedge.net"
        "a-0005.a-msedge.net"
        "a-0006.a-msedge.net"
        "a-0007.a-msedge.net"
        "a-0008.a-msedge.net"
        "a-0009.a-msedge.net"
        "a1621.g.akamai.net"
        "a1856.g2.akamai.net"
        "a1961.g.akamai.net"
        #"a248.e.akamai.net"            #makes iTunes download button disappear (#43)
        "a978.i6g1.akamai.net"
        "a.ads1.msn.com"
        "a.ads2.msads.net"
        "a.ads2.msn.com"
        "ac3.msn.com"
        "ad.doubleclick.net"
        "adnexus.net"
        "adnxs.com"
        "ads1.msads.net"
        "ads1.msn.com"
        "ads.msn.com"
        "aidps.atdmt.com"
        "aka-cdn-ns.adtech.de"
        "a-msedge.net"
        "any.edge.bing.com"
        "a.rad.msn.com"
        "az361816.vo.msecnd.net"
        "az512334.vo.msecnd.net"
        "b.ads1.msn.com"
        "b.ads2.msads.net"
        "bingads.microsoft.com"
        "b.rad.msn.com"
        "bs.serving-sys.com"
        "c.atdmt.com"
        "cdn.atdmt.com"
        "cds26.ams9.msecn.net"
        "choice.microsoft.com"
        "choice.microsoft.com.nsatc.net"
        "compatexchange.cloudapp.net"
        "corpext.msitadfs.glbdns2.microsoft.com"
        "corp.sts.microsoft.com"
        "cs1.wpc.v0cdn.net"
        "db3aqu.atdmt.com"
        "df.Telemetry.microsoft.com"
        "diagnostics.support.microsoft.com"
        "e2835.dspb.akamaiedge.net"
        "e7341.g.akamaiedge.net"
        "e7502.ce.akamaiedge.net"
        "e8218.ce.akamaiedge.net"
        "ec.atdmt.com"
        "fe2.update.microsoft.com.akadns.net"
        "feedback.microsoft-hohm.com"
        "feedback.search.microsoft.com"
        "feedback.windows.com"
        "flex.msn.com"
        "g.msn.com"
        "h1.msn.com"
        "h2.msn.com"
        "hostedocsp.globalsign.com"
        "i1.services.social.microsoft.com"
        "i1.services.social.microsoft.com.nsatc.net"
        "ipv6.msftncsi.com"
        "ipv6.msftncsi.com.edgesuite.net"
        "lb1.www.ms.akadns.net"
        "live.rads.msn.com"
        "m.adnxs.com"
        "msedge.net"
        "msftncsi.com"
        "msnbot-65-55-108-23.search.msn.com"
        "msntest.serving-sys.com"
        "oca.Telemetry.microsoft.com"
        "oca.Telemetry.microsoft.com.nsatc.net"
        "onesettings-db5.metron.live.nsatc.net"
        "pre.footprintpredict.com"
        "preview.msn.com"
        "rad.live.com"
        "rad.msn.com"
        "redir.metaservices.microsoft.com"
        "reports.wes.df.Telemetry.microsoft.com"
        "schemas.microsoft.akadns.net"
        "secure.adnxs.com"
        "secure.flashtalking.com"
        "services.wes.df.Telemetry.microsoft.com"
        "settings-sandbox.data.microsoft.com"
        #"settings-win.data.microsoft.com"       #may cause issues with Windows Updates
        "sls.update.microsoft.com.akadns.net"
        #"sls.update.microsoft.com.nsatc.net"    #may cause issues with Windows Updates
        "sqm.df.Telemetry.microsoft.com"
        "sqm.Telemetry.microsoft.com"
        "sqm.Telemetry.microsoft.com.nsatc.net"
        "ssw.live.com"
        "static.2mdn.net"
        "statsfe1.ws.microsoft.com"
        "statsfe2.update.microsoft.com.akadns.net"
        "statsfe2.ws.microsoft.com"
        "survey.watson.microsoft.com"
        "telecommand.Telemetry.microsoft.com"
        "telecommand.Telemetry.microsoft.com.nsatc.net"
        "Telemetry.appex.bing.net"
        "Telemetry.microsoft.com"
        "Telemetry.urs.microsoft.com"
        "vortex-bn2.metron.live.com.nsatc.net"
        "vortex-cy2.metron.live.com.nsatc.net"
        "vortex.data.microsoft.com"
        "vortex-sandbox.data.microsoft.com"
        "vortex-win.data.microsoft.com"
        "cy2.vortex.data.microsoft.com.akadns.net"
        "watson.live.com"
        "watson.microsoft.com"
        "watson.ppe.Telemetry.microsoft.com"
        "watson.Telemetry.microsoft.com"
        "watson.Telemetry.microsoft.com.nsatc.net"
        "wes.df.Telemetry.microsoft.com"
        "win10.ipv6.microsoft.com"
        "www.bingads.microsoft.com"
        "www.go.microsoft.akadns.net"
        "www.msftncsi.com"
        "client.wns.windows.com"
        #"wdcp.microsoft.com"                       #may cause issues with Windows Defender Cloud-based protection
        #"dns.msftncsi.com"                         #This causes Windows to think it doesn't have internet
        #"storeedgefd.dsx.mp.microsoft.com"         #breaks Windows Store
        "wdcpalt.microsoft.com"
        #"settings-ssl.xboxlive.com"                #Breaks XBOX Live Games
        #"settings-ssl.xboxlive.com-c.edgekey.net"  #Breaks XBOX Live Games
        #"settings-ssl.xboxlive.com-c.edgekey.net.globalredir.akadns.net" #Breaks XBOX Live Games
        "e87.dspb.akamaidege.net"
        "insiderservice.microsoft.com"
        "insiderservice.trafficmanager.net"
        "e3843.g.akamaiedge.net"
        "flightingserviceweurope.cloudapp.net"
        #"sls.update.microsoft.com"                 #may cause issues with Windows Updates
        "static.ads-twitter.com"                    #may cause issues with Twitter login
        "www-google-analytics.l.google.com"
        "p.static.ads-twitter.com"                  #may cause issues with Twitter login
        "hubspot.net.edge.net"
        "e9483.a.akamaiedge.net"
    
        #"www.google-analytics.com"
        #"padgead2.googlesyndication.com"
        #"mirror1.malwaredomains.com"
        #"mirror.cedia.org.ec"
        "stats.g.doubleclick.net"
        "stats.l.doubleclick.net"
        "adservice.google.de"
        "adservice.google.com"
        "googleads.g.doubleclick.net"
        "pagead46.l.doubleclick.net"
        "hubspot.net.edgekey.net"
        "insiderppe.cloudapp.net"                   #Feedback-Hub
        "livetileedge.dsx.mp.microsoft.com"
    
        #extra
        "fe2.update.microsoft.com.akadns.net"
        "s0.2mdn.net"
        "statsfe2.update.microsoft.com.akadns.net"
        "survey.watson.microsoft.com"
        "view.atdmt.com"
        "watson.microsoft.com"
        "watson.ppe.Telemetry.microsoft.com"
        "watson.Telemetry.microsoft.com"
        "watson.Telemetry.microsoft.com.nsatc.net"
        "wes.df.Telemetry.microsoft.com"
        "m.hotmail.com"
    
        #can cause issues with Skype (#79) or other services (#171)
        "apps.skype.com"
        "c.msn.com"
        #"login.live.com"                  #prevents login to outlook and other live apps
        "pricelist.skype.com"
        "s.gateway.messenger.live.com"
        "ui.skype.com"
    )
    Write-Host "" | Out-File -Encoding ASCII -Append $hosts_file
    foreach ($domain in $domains) {
        if (-Not (Select-String -Path $hosts_file -Pattern $domain)) {
            Write-Host "0.0.0.0 $domain" | Out-File -Encoding ASCII -Append $hosts_file
        }
    }
    
    Write-Host "Adding Telemetry ips to firewall"
    $ips = @(
        "134.170.30.202"
        "137.116.81.24"
        "157.56.106.189"
        "184.86.53.99"
        "2.22.61.43"
        "2.22.61.66"
        "204.79.197.200"
        "23.218.212.69"
        "65.39.117.230"
        "65.52.108.33"   #Causes problems with Microsoft Store
        "65.55.108.23"
        "64.4.54.254"
    )
    Remove-NetFirewallRule -DisplayName "Block Telemetry IPs" -ErrorAction SilentlyContinue | Out-Null
    New-NetFirewallRule -DisplayName "Block Telemetry IPs" -Direction Outbound `
        -Action Block -RemoteAddress ([string[]]$ips) | Out-Null
    
    Write-Host "Importing Policies"
    #GPO Configurations
    $gposdir = "$(Get-Location)\Files\GPOs"
    Foreach ($gpocategory in Get-ChildItem "$(Get-Location)\Files\GPOs") {
        
        Write-Host "Importing $gpocategory Policies"
    
        Foreach ($gpo in (Get-ChildItem "$(Get-Location)\Files\GPOs\$gpocategory")) {
            $gpopath = "$gposdir\$gpocategory\$gpo"
            Write-Host "Importing $gpo ...."
            .\Files\LGPO\LGPO.exe /g $gpopath > $null 2>&1
            Write-Host "Done"
        }
    }
    Add-Type -AssemblyName PresentationFramework
    $Answer = [System.Windows.MessageBox]::Show("Reboot to make changes effective?", "Restart Computer", "YesNo", "Question")
    Switch ($Answer) {
        "Yes" { Write-Host "Performing Gpupdate"; Get-Job; Gpupdate /force /boot; Write-Warning "Restarting Computer in 15 Seconds"; Start-sleep -seconds 15; Restart-Computer -Force }
        "No" { Write-Host "Performing Gpupdate" ; Get-Job; Gpupdate /force; Write-Warning "A reboot is required for all changed to take effect" }
        Default { Write-Warning "A reboot is required for all changed to take effect" }
    }
    Write-host "Edited Host (Locked Telemetry)" 
    $WPFp24.IsChecked = $false
    }
        If ( $WPFp25.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut"
    New-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 0
    Write-host "Enabled Languages Options" 
    $WPFp25.IsChecked = $false
    }
        If ( $WPFp26.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 1
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -ErrorAction SilentlyContinue
    Write-host "Enabled Suggested Apps" 
    $WPFp26.IsChecked = $false
    }
        If ( $WPFp27.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 3
    Start-Service DiagTrack | Set-Service -StartupType Automatic
    Start-Service dmwappushservice | Set-Service -StartupType Automatic
    Write-host "Enabled Telemetry" 
    $WPFp27.IsChecked = $false
    }
        If ( $WPFp28.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -ErrorAction SilentlyContinue
    Write-host "Enabled Activity History" 
    $WPFp28.IsChecked = $false
    }
        If ( $WPFp29.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 1
    Write-host "Enabled Location Tracking" 
    $WPFp29.IsChecked = $false
    }
        If ( $WPFp30.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -ErrorAction SilentlyContinue
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
    Write-host "Enabled Error Reporting" 
    $WPFp30.IsChecked = $false
    }
        If ( $WPFp31.IsChecked -eq $true ) {
    Set-Service "DiagTrack" -StartupType Automatic
    Start-Service "DiagTrack" -WarningAction SilentlyContinue
    Write-host "Enabled Diagnostic Tracking" 
    $WPFp31.IsChecked = $false
    }
        If ( $WPFp32.IsChecked -eq $true ) {
    Set-Service "dmwappushservice" -StartupType Automatic
    Start-Service "dmwappushservice" -WarningAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice" -Name "DelayedAutoStart" -Type DWord -Value 1
    Write-host "Enabled WAP Push Service" 
    $WPFp32.IsChecked = $false
    }
        If ( $WPFp33.IsChecked -eq $true ) {
    Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
    Set-Service "HomeGroupListener" -StartupType Manual
    Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
    Set-Service "HomeGroupProvider" -StartupType Manual
    Write-host "Enabled Home Group Services" 
    $WPFp33.IsChecked = $false
    }
        If ( $WPFp34.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 1
    Write-host "Enabled Remote Assistance" 
    $WPFp34.IsChecked = $false
    }
        If ( $WPFp35.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "04" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "08" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "32" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "StoragePoliciesNotified" -Type DWord -Value 1
    Write-host "Enabled Storage Check" 
    $WPFp35.IsChecked = $false
    }
        If ( $WPFp36.IsChecked -eq $true ) {
    Set-Service "SysMain" -StartupType Automatic
    Start-Service "SysMain" -WarningAction SilentlyContinue
    Write-host "Enabled Superfetch" 
    $WPFp36.IsChecked = $false
    }
        If ( $WPFp37.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 1
    Write-host "Enabled Hibernation" 
    $WPFp37.IsChecked = $false
    }
        If ( $WPFp38.IsChecked -eq $true ) {
            $ErrorActionPreference = 'SilentlyContinue'
        $Keys = @(
            
            New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
            #Remove Background Tasks
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
            #Windows File
            "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
            #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
            #Scheduled Tasks to delete
            "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
            #Windows Protocol Keys
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
            "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
                
            #Windows Share Target
            "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        )
    Write-host "Add Keys to Registry for Privacy" 
    $WPFp38.IsChecked = $false
    }
        If ( $WPFp39.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Type Hex -Value 00000000
    Set-ItemProperty -Path "HKLM:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 00000000
    Write-host "Enabled Tweaks GameDVR" 
    $WPFp39.IsChecked = $false
    }
        If ( $WPFp40.IsChecked -eq $true ) {
    Disable-ComputerRestore -Drive "$env:SYSTEMDRIVE"
    Write-host "Disabled System Recovery" 
    $WPFp40.IsChecked = $false
    }
        If ( $WPFp41.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 0
    Write-host "Enabled Optimization Fullscreen" 
    $WPFp41.IsChecked = $false
    }
        If ( $WPFp42.IsChecked -eq $true ) {
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
    Write-host "Enabled Scheduled Defrag" 
    $WPFp42.IsChecked = $false
    }
        If ( $WPFp43IsChecked -eq $true ) {
    Get-AppxPackage -AllUsers "Microsoft.XboxApp" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -AllUsers "Microsoft.XboxIdentityProvider" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -AllUsers "Microsoft.XboxSpeechToTextOverlay" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -AllUsers "Microsoft.XboxGameOverlay" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -AllUsers "Microsoft.Xbox.TCUI" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 1
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
    Write-host "Enabled Xbox Features" 
    $WPFp43IsChecked.IsChecked = $false
    }
        If ( $WPFp44.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 1
    Write-host "Enabled Fast Startup" 
    $WPFp44.IsChecked = $false
    }
        If ( $WPFp45.IsChecked -eq $true ) {
    Get-AppxPackage -AllUsers "Microsoft.DesktopAppInstaller" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Get-AppxPackage -AllUsers "Microsoft.WindowsStore" | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Write-host "Installed Microsoft Store" 
    $WPFp45.IsChecked = $false
    }
        If ( $WPFp46.IsChecked -eq $true ) {
    $ErrorActionPreference = 'SilentlyContinue'
    $Bandwidth = "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
    Remove-ItemProperty -Path $Bandwidth -Name "NonBestEffortLimit"
    Write-host "Normal Bandwidth" 
    $WPFp46.IsChecked = $false
    }


    Write-Host "All Selected Tweaks are activated successfully"
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############### Utility ##################
##########################################

$WPFTab5P1.Add_Click({
    $WPFut1.IsChecked = $true
    $WPFut2.IsChecked = $true
    $WPFut3.IsChecked = $true
    $WPFut4.IsChecked = $true
    $WPFut5.IsChecked = $true
    $WPFut6.IsChecked = $true
    $WPFut7.IsChecked = $true
    $WPFut8.IsChecked = $true
    $WPFut9.IsChecked = $true
    $WPFut10.IsChecked = $true
    $WPFut11.IsChecked = $true
    $WPFut12.IsChecked = $false
    $WPFut13.IsChecked = $true
    $WPFut14.IsChecked = $true
    $WPFut15.IsChecked = $true
    $WPFut16.IsChecked = $true
    $WPFut17.IsChecked = $true
    $WPFut18.IsChecked = $true
    $WPFut19.IsChecked = $false
    $WPFut20.IsChecked = $false
    $WPFut21.IsChecked = $false
    $WPFut22.IsChecked = $true
    $WPFut23.IsChecked = $true
    $WPFut24.IsChecked = $false
    $WPFut25.IsChecked = $false
    $WPFut26.IsChecked = $false
    $WPFut27.IsChecked = $false
    $WPFut28.IsChecked = $false
    $WPFut29.IsChecked = $false
    $WPFut30.IsChecked = $false
    $WPFut31.IsChecked = $false
    $WPFut32.IsChecked = $false
    $WPFut33.IsChecked = $false
    $WPFut34.IsChecked = $false
    $WPFut35.IsChecked = $true
    $WPFut36.IsChecked = $false
    $WPFut37.IsChecked = $false
    $WPFut38.IsChecked = $false
    $WPFut39.IsChecked = $false
    $WPFut40.IsChecked = $true
    $WPFut41.IsChecked = $false
    $WPFut42.IsChecked = $false
    $WPFut43.IsChecked = $false
    $WPFut44.IsChecked = $false
    $WPFut45.IsChecked = $false
    $WPFut46.IsChecked = $false

})

$WPFTab5P2.Add_Click({

        If ( $WPFut1.IsChecked -eq $true ) {
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
        Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
    }
    Write-host "Disabled Background App Access" 
    $WPFut1.IsChecked = $false
    }
        If ( $WPFut2.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
    Write-host "Disabled Automatic Maps Updates" 
    $WPFut2.IsChecked = $false
    }
        If ( $WPFut3.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-host "Disabled Feedback" 
    $WPFut3.IsChecked = $false
    }
        If ( $WPFut4.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableMmx" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
        New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
    Write-host "Disabled Tailored Experiences" 
    $WPFut4.IsChecked = $false
    }
        If ( $WPFut5.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    Write-host "Disabled Advertising ID" 
    $WPFut5.IsChecked = $false
    }
        If ( $WPFut6.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
    Write-host "Disabled Smartscreen Filter" 
    $WPFut6.IsChecked = $false
    }
        If ( $WPFut7.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type Dword -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type Dword -Value 0
    Write-host "Disabled WiFi-Sense" 
    $WPFut7.IsChecked = $false
    }
        If ( $WPFut8.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer" -Name "DisableFlashInIE" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" -Name "FlashPlayerEnabled" -Type DWord -Value 0
    Write-host "Disabled Adobe Flash" 
    $WPFut8.IsChecked = $false
    }
        If ( $WPFut9.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Type DWord -Value 1
    Write-host "Disabled IE First Access" 
    $WPFut9.IsChecked = $false
    }
        If ( $WPFut10.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Type DWord -Value 1
    Write-host "NTFS >260 Characters" 
    $WPFut10.IsChecked = $false
    }
        If ( $WPFut11.IsChecked -eq $true ) {
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
    If (Test-Path $CloudStore) {
        Stop-Process Explorer.exe -Force
        Remove-Item $CloudStore -Recurse -Force
        Start-Process Explorer.exe -Wait
    }
    Write-host "Disabled Cloudstore" 
    $WPFut11.IsChecked = $false
    }
        If ( $WPFut12.IsChecked -eq $true ) {
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
    If (!(Test-Path $registryPath)) {
        Mkdir $registryPath
        New-ItemProperty $registryPath AutoDownload -Value 2 
    }
    Set-ItemProperty $registryPath AutoDownload -Value 2
    Write-host "Disabled Automatic Update from Microsoft Store" 
    $WPFut12.IsChecked = $false
    }
        If ( $WPFut13.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
    Write-host "Set BIOS UTC Time" 
    $WPFut13.IsChecked = $false
    }
        If ( $WPFut14.IsChecked -eq $true ) {
    $NoPDF = "HKCR:\.pdf"
    $NoProgids = "HKCR:\.pdf\OpenWithProgids"
    $NoWithList = "HKCR:\.pdf\OpenWithList" 
    If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
        New-ItemProperty $NoPDF NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
        New-ItemProperty $NoPDF  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
        New-ItemProperty $NoProgids  NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
        New-ItemProperty $NoProgids  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
        New-ItemProperty $NoWithList  NoOpenWith
    }        
    If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
        New-ItemProperty $NoWithList  NoStaticDefaultVerb 
    }
        
    #Appends an underscore '_' to the Registry key for Edge
    $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    If (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
    } 
    Write-host "Disabled PDF Control in Edge" 
    $WPFut14.IsChecked = $false
    }
        If ( $WPFut15.IsChecked -eq $true ) {
    powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    Write-host "Custom Powerplan Installed" 
    $WPFut15.IsChecked = $false
    }
        If ( $WPFut16.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
    Write-host "Set IRP Stack Size to 20" 
    $WPFut16.IsChecked = $false
    }
        If ( $WPFut17.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4194304
    Write-host "Set SVChost Tweak" 
    $WPFut17.IsChecked = $false
    }
        If ( $WPFut18.IsChecked -eq $true ) {
    fsutil behavior set DisableLastAccess 1
    fsutil behavior set EncryptPagingFile 0
    Write-host "Set Better SSD Use" 
    $WPFut18.IsChecked = $false
    }
        If ( $WPFut19.IsChecked -eq $true ) {
    If ([System.Environment]::OSVersion.Version.Build -ge 17763) {
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Type DWord -Value 2
    } Else {
        Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*", "Microsoft.Windows.ShellExperienceHost*" | ForEach-Object {
            Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
            Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
        }
    }
    Write-Host "Disabling access to voice activation from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -Type DWord -Value 2
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type DWord -Value 2
    Write-Host "Disabling access to notifications from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -Type DWord -Value 2
    Write-Host "Disabling access to account info from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessAccountInfo" -Type DWord -Value 2
    Write-Host "Disabling access to contacts from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessContacts" -Type DWord -Value 2
    Write-Host "Disabling access to calendar from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCalendar" -Type DWord -Value 2
    Write-Host "Disabling access to phone calls from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessPhone" -Type DWord -Value 2
    Write-Host "Disabling access to call history from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCallHistory" -Type DWord -Value 2
    Write-Host "Disabling access to email from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessEmail" -Type DWord -Value 2
    Write-Host "Disabling access to tasks from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessTasks" -Type DWord -Value 2
    Write-Host "Disabling access to messaging from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMessaging" -Type DWord -Value 2
    Write-Host "Disabling access to radios from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessRadios" -Type DWord -Value 2
    Write-Host "Disabling access to other devices from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsSyncWithDevices" -Type DWord -Value 2
    Write-Host "Disabling access to diagnostic information from UWP apps..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsGetDiagnosticInfo" -Type DWord -Value 2
    Write-Host "Disabling access to libraries and file system from UWP apps..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Type String -Value "Deny"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Type String -Value "Deny"
    Write-Host "Disabling UWP apps swap file..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -Type Dword -Value 0
    Write-host "Disabled UWP App Access" 
    $WPFut19.IsChecked = $false
    }
        If ( $WPFut20.IsChecked -eq $true ) {
    $DriveLetters = (Get-WmiObject -Class Win32_Volume).DriveLetter
    ForEach ($Drive in $DriveLetters) {
        If (-not ([string]::IsNullOrEmpty($Drive))) {
            $indexing = $Drive.IndexingEnabled
        }
    Write-host "Enable Disk Compression" 
    $WPFut20.IsChecked = $false
    }
        }
        If ( $WPFut21.IsChecked -eq $true ) {
    Stop-Service "MessagingService"
    Set-Service "MessagingService" -StartupType Disabled
    Stop-Service "PimIndexMaintenanceSvc"
    Set-Service "PimIndexMaintenanceSvc" -StartupType Disabled
    Stop-Service "RetailDemo"
    Set-Service "RetailDemo" -StartupType Disabled
    Stop-Service "MapsBroker"
    Set-Service "MapsBroker" -StartupType Disabled
    Stop-Service "DoSvc"
    Set-Service "DoSvc" -StartupType Disabled
    Stop-Service "OneSyncSvc"
    Set-Service "OneSyncSvc" -StartupType Disabled
    Stop-Service "UnistoreSvc"
    Set-Service "UnistoreSvc" -StartupType Disabled

        $services = @(
    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
    "DiagTrack"                                # Diagnostics Tracking Service
    "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)
    "lfsvc"                                    # Geolocation Service
    "MapsBroker"                               # Downloaded Maps Manager
    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
    "RemoteAccess"                             # Routing and Remote Access
    "RemoteRegistry"                           # Remote Registry
    "SharedAccess"                             # Internet Connection Sharing (ICS)
    "TrkWks"                                   # Distributed Link Tracking Client
    "WbioSrvc"                                 # Windows Biometric Service (required for Fingerprint reader / facial detection)
    #"WlanSvc"                                 # WLAN AutoConfig
    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
    #"wscsvc"                                  # Windows Security Center Service
    #"WSearch"                                 # Windows Search
    "XblAuthManager"                           # Xbox Live Auth Manager
    "XblGameSave"                              # Xbox Live Game Save Service
    "XboxNetApiSvc"                            # Xbox Live Networking Service
    "ndu"                                      # Windows Network Data Usage Monitor
    # Services which cannot be disabled
    #"WdNisSvc"
    )

    foreach ($service in $services) {
        Write-Host "Trying to disable $service"
        Get-Service -Name $service | Set-Service -StartupType Disabled
    }
    Write-host "Disabled Useless Services" 
    $WPFut21.IsChecked = $false
    }
        If ( $WPFut22.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 1
    Disable-NetFirewallRule -Name "RemoteDesktop*"
    Write-host "Disabled Remote Desktop" 
    $WPFut22.IsChecked = $false
    }
        If ( $WPFut23.IsChecked -eq $true ) {
    $obj = Get-WmiObject -Class Win32_Volume -Filter "DriveLetter='$Drive'"
    $indexing = $obj.IndexingEnabled
    if("$indexing" -eq $True){
        write-host "Disabling indexing of drive $Drive"
        $obj | Set-WmiInstance -Arguments @{IndexingEnabled=$False} | Out-Null
    }
    Write-host "Disabled Indexing" 
    $WPFut23.IsChecked = $false
    }
        If ( $WPFut24.IsChecked -eq $true ) {
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
        Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
    }
    Write-host "Enabled Background App Access" 
    $WPFut24.IsChecked = $false
    }
        If ( $WPFut25.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -ErrorAction SilentlyContinue
    Write-host "Enabled Automatic Maps Updates" 
    $WPFut25.IsChecked = $false
    }
        If ( $WPFut26.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -ErrorAction SilentlyContinue
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
    Enable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    Write-host "Enabled Feedback" 
    $WPFut26.IsChecked = $false
    }
        If ( $WPFut27.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -ErrorAction SilentlyContinue
    Write-host "Enabled Tailored Experiences" 
    $WPFut27.IsChecked = $false
    }
        If ( $WPFut28.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -ErrorAction SilentlyContinue
    Write-host "Enabled Advertising ID" 
    $WPFut28.IsChecked = $false
    }
        If ( $WPFut29.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -ErrorAction SilentlyContinue
    Write-host "Enabled Smartscreen Filter" 
    $WPFut29.IsChecked = $false
    }
        If ( $WPFut30.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 1
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -ErrorAction SilentlyContinue
    Write-host "Enabled WiFi-Sense" 
    $WPFut30.IsChecked = $false
    }
        If ( $WPFut31.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -ErrorAction SilentlyContinue
    Write-host "Hided Seconds from Taskbar" 
    $WPFut31.IsChecked = $false
    }
        If ( $WPFut32.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Type DWord -Value 1
    Write-host "Showed Seconds from Taskbar" 
    $WPFut32.IsChecked = $false
    }
        If ( $WPFut33.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "link" -Type Binary -Value ([byte[]](0,0,0,0))
    Write-host "Disabled adding '- Shortcut' to shorcut name" 
    $WPFut33.IsChecked = $false
    }
        If ( $WPFut34.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "link" -ErrorAction SilentlyContinue
    Write-host "Enabled adding '- Shortcut' to shorcut name" 
    $WPFut34.IsChecked = $false
    }
        If ( $WPFut35.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0
    Write-host "Disabled News and Interests" 
    $WPFut35.IsChecked = $false
    }
        If ( $WPFut36.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 0
    Write-host "BIOS in Local Time" 
    $WPFut36.IsChecked = $false
    }
        If ( $WPFut37.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons")) {
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" -Name "29" -Type String -Value "%SystemRoot%\System32\imageres.dll,-1015"
    Write-host "Hided Shortcut Icon Arrow" 
    $WPFut37.IsChecked = $false
    }
        If ( $WPFut38.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" -Name "29" -ErrorAction SilentlyContinue
    Write-host "Showed Shortcut Icon Arrow" 
    $WPFut38.IsChecked = $false
    }
        If ( $WPFut39.IsChecked -eq $true ) {
	If (!(Test-Path "HKU:")) {
		New-PSDrive -Name "HKU" -PSProvider "Registry" -Root "HKEY_USERS" | Out-Null
	}
	Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483648
	Add-Type -AssemblyName System.Windows.Forms
	If ([System.Windows.Forms.Control]::IsKeyLocked('NumLock')) {
		$wsh = New-Object -ComObject WScript.Shell
		$wsh.SendKeys('{NUMLOCK}')
	}
    Write-host "Disabled NumLock after Startup" 
    $WPFut39.IsChecked = $false
    }
        If ( $WPFut40.IsChecked -eq $true ) {
	If (!(Test-Path "HKU:")) {
		New-PSDrive -Name "HKU" -PSProvider "Registry" -Root "HKEY_USERS" | Out-Null
	}
	Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
	Add-Type -AssemblyName System.Windows.Forms
	If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
		$wsh = New-Object -ComObject WScript.Shell
		$wsh.SendKeys('{NUMLOCK}')
	}
    Write-host "Enabled NumLock after Startup" 
    $WPFut40.IsChecked = $false
    }
        If ( $WPFut41.IsChecked -eq $true ) {
	Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "0"
	Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Type String -Value "0"
	Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Type String -Value "0"
    Write-host "Disabled Enhanced Pointer Precision" 
    $WPFut41.IsChecked = $false
    }
        If ( $WPFut42.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "1"
	Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Type String -Value "6"
	Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Type String -Value "10"
    Write-host "Enabled Enhanced Pointer Precision" 
    $WPFut42.IsChecked = $false
    }
        If ( $WPFut43IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 00000000
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Type DWord -Value 0000000a
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 0000000a
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Type DWord -Value 2000
    Set-ItemProperty -Path "HKLM:\Control Panel\Desktop" -Name "MenuShowDelay" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Type DWord -Value 5000
    Set-ItemProperty -Path "HKLM:\Control Panel\Desktop" -Name "HungAppTimeout" -Type DWord -Value 4000
    Set-ItemProperty -Path "HKLM:\Control Panel\Desktop" -Name "AutoEndTasks" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\Control Panel\Desktop" -Name "LowLevelHooksTimeout" -Type DWord -Value 00001000
    Set-ItemProperty -Path "HKLM:\Control Panel\Desktop" -Name "WaitToKillServiceTimeout" -Type DWord -Value 00002000
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Type DWord -Value 00000001
    Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\Ndu" -Name "Start" -Type DWord -Value 00000004
    Set-ItemProperty -Path "HKLM:\Control Panel\Mouse" -Name "MouseHoverTime" -Type DWord -Value 00000010
    Write-host "More Telemetry Enabled" 
    $WPFut43IsChecked.IsChecked = $false
    }
        If ( $WPFut44.IsChecked -eq $true ) {
    $services = @(
        "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
        "DiagTrack"                                    # Diagnostics Tracking Service
        "DPS"
        "dmwappushservice"                             # WAP Push Message Routing Service (see known issues)
        "lfsvc"                                        # Geolocation Service
        "MapsBroker"                                   # Downloaded Maps Manager
        "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
        "RemoteAccess"                                 # Routing and Remote Access
        "RemoteRegistry"                               # Remote Registry
        "SharedAccess"                                 # Internet Connection Sharing (ICS)
        "TrkWks"                                       # Distributed Link Tracking Client
        #"WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
        #"WlanSvc"                                      # WLAN AutoConfig
        "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
        #"wscsvc"                                       # Windows Security Center Service
        "WSearch"                                      # Windows Search
        "XblAuthManager"                               # Xbox Live Auth Manager
        "XblGameSave"                                  # Xbox Live Game Save Service
        "XboxNetApiSvc"                                # Xbox Live Networking Service
        "XboxGipSvc"                                   #Disables Xbox Accessory Management Service
        "ndu"                                          # Windows Network Data Usage Monitor
        "WerSvc"                                       #disables windows error reporting
        #"Spooler"                                      #Disables your printer
        "Fax"                                          #Disables fax
        "fhsvc"                                        #Disables fax histroy
        "gupdate"                                      #Disables google update
        "gupdatem"                                     #Disable another google update
        "stisvc"                                       #Disables Windows Image Acquisition (WIA)
        "AJRouter"                                     #Disables (needed for AllJoyn Router Service)
        "MSDTC"                                        # Disables Distributed Transaction Coordinator
        "WpcMonSvc"                                    #Disables Parental Controls
        "PhoneSvc"                                     #Disables Phone Service(Manages the telephony state on the device)
        "PrintNotify"                                  #Disables Windows printer notifications and extentions
        "PcaSvc"                                       #Disables Program Compatibility Assistant Service
        "WPDBusEnum"                                   #Disables Portable Device Enumerator Service
        #"LicenseManager"                               #Disable LicenseManager(Windows store may not work properly)
        "seclogon"                                     #Disables  Secondary Logon(disables other credentials only password will work)
        "SysMain"                                      #Disables sysmain
        "lmhosts"                                      #Disables TCP/IP NetBIOS Helper
        "wisvc"                                        #Disables Windows Insider program(Windows Insider will not work)
        "FontCache"                                    #Disables Windows font cache
        "RetailDemo"                                   #Disables RetailDemo whic is often used when showing your device
        "ALG"                                          # Disables Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
        #"BFE"                                         #Disables Base Filtering Engine (BFE) (is a service that manages firewall and Internet Protocol security)
        #"BrokerInfrastructure"                         #Disables Windows infrastructure service that controls which background tasks can run on the system.
        "SCardSvr"                                      #Disables Windows smart card
        "EntAppSvc"                                     #Disables enterprise application management.
        "BthAvctpSvc"                                   #Disables AVCTP service (if you use  Bluetooth Audio Device or Wireless Headphones. then don't disable this)
        #"FrameServer"                                   #Disables Windows Camera Frame Server(this allows multiple clients to access video frames from camera devices.)
        "Browser"                                       #Disables computer browser
        "BthAvctpSvc"                                   #AVCTP service (This is Audio Video Control Transport Protocol service.)
        #"BDESVC"                                        #Disables bitlocker
        "iphlpsvc"                                      #Disables ipv6 but most websites don't use ipv6 they use ipv4     
        "edgeupdate"                                    # Disables one of edge update service  
        "MicrosoftEdgeElevationService"                 # Disables one of edge  service 
        "edgeupdatem"                                   # disbales another one of update service (disables edgeupdatem)                          
        "SEMgrSvc"                                      #Disables Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
        #"PNRPsvc"                                      # Disables peer Name Resolution Protocol ( some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
        #"p2psvc"                                       # Disbales Peer Name Resolution Protocol(nables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)
        #"p2pimsvc"                                     # Disables Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly.Discord will still work)
        "PerfHost"                                      #Disables  remote users and 64-bit processes to query performance .
        "BcastDVRUserService_48486de"                   #Disables GameDVR and Broadcast   is used for Game Recordings and Live Broadcasts
        "CaptureService_48486de"                        #Disables ptional screen capture functionality for applications that call the Windows.Graphics.Capture API.  
        "cbdhsvc_48486de"                               #Disables   cbdhsvc_48486de (clipboard service it disables)
        #"BluetoothUserService_48486de"                  #disbales BluetoothUserService_48486de (The Bluetooth user service supports proper functionality of Bluetooth features relevant to each user session.)
        "WpnService"                                    #Disables WpnService (Push Notifications may not work )
        #"StorSvc"                                       #Disables StorSvc (usb external hard drive will not be reconised by windows)
        "RtkBtManServ"                                  #Disables Realtek Bluetooth Device Manager Service
        "QWAVE"                                         #Disables Quality Windows Audio Video Experience (audio and video might sound worse)
        #Hp services
        "HPAppHelperCap"
        "HPDiagsCap"
        "HPNetworkCap"
        "HPSysInfoCap"
        "HpTouchpointAnalyticsService"
        #hyper-v services
        "HvHost"                          
        "vmickvpexchange"
        "vmicguestinterface"
        "vmicshutdown"
        "vmicheartbeat"
        "vmicvmsession"
        "vmicrdv"
        "vmictimesync" 
        # Services which cannot be disabled
        #"WdNisSvc"
    )
    
    foreach ($service in $services) {
        # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist
    
        Write-Host "Setting $service StartupType to Manual"
        Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
    }
    Write-host "More Services to Manual" 
    $WPFut44.IsChecked = $false
    }
        If ( $WPFut45.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Type DWord -Value 0
    Enable-NetFirewallRule -Name "RemoteDesktop*"
    Write-host "Enabled Remote Desktop" 
    $WPFut45.IsChecked = $false
    }
        If ( $WPFut46.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to libraries and file system from UWP apps..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Type String -Value "Allow"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Type String -Value "Allow"
    Write-Host "Enabling access to diagnostic information from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsGetDiagnosticInfo" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to other devices from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsSyncWithDevices" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to radios from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessRadios" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to messaging from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMessaging" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to tasks from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessTasks" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to email from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessEmail" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to call history from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCallHistory" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to phone calls from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessPhone" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to calendar from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCalendar" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to contacts from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessContacts" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to account info from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessAccountInfo" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to notifications from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -ErrorAction SilentlyContinue
    Write-Host "Enabling access to voice activation from UWP apps..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -ErrorAction SilentlyContinue
    Write-Host "Enabling UWP apps background access..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -ErrorAction SilentlyContinue
    Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" | ForEach-Object {
        Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
    }
    Write-host "Enabled UWP App Access"  
    $WPFut46.IsChecked = $false
    }


    Write-Host "All Selected Tweaks are activated successfully"
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Defender ##################
##########################################

$WPFTab6P1.Add_Click({
    $WPFd1.IsChecked = $false
    $WPFd2.IsChecked = $false
    $WPFd3.IsChecked = $false
    $WPFd4.IsChecked = $false
    $WPFd5.IsChecked = $false
    $WPFd6.IsChecked = $false
    $WPFd7.IsChecked = $false
    $WPFd8.IsChecked = $false
    $WPFd9.IsChecked = $false
    $WPFd10.IsChecked = $false
    $WPFd11.IsChecked = $false
    $WPFd12.IsChecked = $false
    $WPFd13.IsChecked = $false
    $WPFd14.IsChecked = $false
    $WPFd15.IsChecked = $false
    $WPFd16.IsChecked = $false
    $WPFd17.IsChecked = $false
    $WPFd18.IsChecked = $false
    $WPFd19.IsChecked = $false
    $WPFd20.IsChecked = $false
    $WPFd21.IsChecked = $false
    $WPFd22.IsChecked = $false
    $WPFd23.IsChecked = $false
    $WPFd24.IsChecked = $false
    $WPFd25.IsChecked = $true
    $WPFd26.IsChecked = $true
    $WPFd27.IsChecked = $true
    $WPFd28.IsChecked = $true
    $WPFd29.IsChecked = $true
    $WPFd30.IsChecked = $true
    $WPFd31.IsChecked = $true
    $WPFd32.IsChecked = $true
    $WPFd33.IsChecked = $true
    $WPFd34.IsChecked = $true
    $WPFd35.IsChecked = $true
    $WPFd36.IsChecked = $true
    $WPFd37.IsChecked = $true
    $WPFd38.IsChecked = $true
    $WPFd39.IsChecked = $true
    $WPFd40.IsChecked = $true
    $WPFd41.IsChecked = $true
    $WPFd42.IsChecked = $true
    $WPFd43.IsChecked = $true
    $WPFd44.IsChecked = $true
    $WPFd45.IsChecked = $true
    $WPFd46.IsChecked = $true
    $WPFd47.IsChecked = $true
    $WPFd48.IsChecked = $true

})

$WPFTab6P2.Add_Click({
    $WPFd1.IsChecked = $false
    $WPFd2.IsChecked = $true
    $WPFd3.IsChecked = $false
    $WPFd4.IsChecked = $true
    $WPFd5.IsChecked = $true
    $WPFd6.IsChecked = $true
    $WPFd7.IsChecked = $true
    $WPFd8.IsChecked = $false
    $WPFd9.IsChecked = $true
    $WPFd10.IsChecked = $true
    $WPFd11.IsChecked = $true
    $WPFd12.IsChecked = $false
    $WPFd13.IsChecked = $false
    $WPFd14.IsChecked = $true
    $WPFd15.IsChecked = $false
    $WPFd16.IsChecked = $false
    $WPFd17.IsChecked = $false
    $WPFd18.IsChecked = $false
    $WPFd19.IsChecked = $false
    $WPFd20.IsChecked = $false
    $WPFd21.IsChecked = $false
    $WPFd22.IsChecked = $false
    $WPFd23.IsChecked = $false
    $WPFd24.IsChecked = $false
    $WPFd25.IsChecked = $false
    $WPFd26.IsChecked = $false
    $WPFd27.IsChecked = $false
    $WPFd28.IsChecked = $false
    $WPFd29.IsChecked = $false
    $WPFd30.IsChecked = $false
    $WPFd31.IsChecked = $false
    $WPFd32.IsChecked = $false
    $WPFd33.IsChecked = $false
    $WPFd34.IsChecked = $false
    $WPFd35.IsChecked = $false
    $WPFd36.IsChecked = $false
    $WPFd37.IsChecked = $false
    $WPFd38.IsChecked = $false
    $WPFd39.IsChecked = $false
    $WPFd40.IsChecked = $false
    $WPFd41.IsChecked = $false
    $WPFd42.IsChecked = $false
    $WPFd43.IsChecked = $false
    $WPFd44.IsChecked = $true
    $WPFd45.IsChecked = $false
    $WPFd46.IsChecked = $false
    $WPFd47.IsChecked = $false
    $WPFd48.IsChecked = $false

})

$WPFTab6P3.Add_Click({

        If ( $WPFd1.IsChecked -eq $true ) {
    Set-MpPreference -EnableControlledFolderAccess Disabled -ErrorAction SilentlyContinue
    Write-Host "Disabled Controlled Folder Access"        
    $WPFd1.IsChecked = $false
    }
        If ( $WPFd2.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -ErrorAction SilentlyContinue
    Write-Host "Disabled Core Isolation Memory Integrity"
    $WPFd2.IsChecked = $false
    }
        If ( $WPFd3.IsChecked -eq $true ) {
    Disable-WindowsOptionalFeature -online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Windows Defender Application Guard"
    $WPFd3.IsChecked = $false
    }
        If ( $WPFd4.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows Security Health\State")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Force | Out-Null
    }
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -Type DWord -Value 1
    Write-Host "Hided Account Protection Warning"
    $WPFd4.IsChecked = $false
    }
        If ( $WPFd5.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWord -Value 1
    Write-Host "Disabled Block of Downloaded Files"
    $WPFd5.IsChecked = $false
    }
        If ( $WPFd6.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -Type DWord -Value 0
    Write-Host "Disabled Windows Script Host"
    $WPFd6.IsChecked = $false
    }
        If ( $WPFd7.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
    Write-Host "Disabled .NET Strong Cryptography"
    $WPFd7.IsChecked = $false
    }
        If ( $WPFd8.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" -Name "cadca5fe-87d3-4b96-b7fb-a231484277cc" -ErrorAction SilentlyContinue
    Write-Host "Disalbed Meltdown (CVE-2017-5754) Compatibility Flag"
    $WPFd8.IsChecked = $false
    }
        If ( $WPFd9.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
    Write-Host "Minimum UAC Level"
    $WPFd9.IsChecked = $false
    }
        If ( $WPFd10.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -ErrorAction SilentlyContinue
    Write-Host "Disabled Share Mapped Drives Between Users"
    $WPFd10.IsChecked = $false
    }
        If ( $WPFd11.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -Type DWord -Value 0
    Write-Host "Disabled Implicit Administrative Shares"
    $WPFd11.IsChecked = $false
    }
        If ( $WPFd12.IsChecked -eq $true ) {
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
    Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
    Write-Host "Disabled SMB Server"
    $WPFd12.IsChecked = $false
    }
        If ( $WPFd13.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Type DWord -Value 0
    Write-Host "Disabled LLMNR"
    $WPFd13.IsChecked = $false
    }
        If ( $WPFd14.IsChecked -eq $true ) {
    Set-NetConnectionProfile -NetworkCategory Private
    Write-Host "Set Current Network Profile to Private"
    $WPFd14.IsChecked = $false
    }
        If ( $WPFd15.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Name "Category" -Type DWord -Value 1
    Write-Host "Set Unknown Networks Profile to Private"
    $WPFd15.IsChecked = $false
    }
        If ( $WPFd16.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Name "AutoSetup" -Type DWord -Value 0
    Write-Host "Disabled Automatic Installation of Network Devices"
    $WPFd16.IsChecked = $false
    }
        If ( $WPFd17.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "EnableFirewall" -Type DWord -Value 0
    Write-Host "Disabled Firewall"
    $WPFd17.IsChecked = $false
    }
        If ( $WPFd18.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1
    If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
    } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
    }
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defende\Real-Time Protectionr")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableBehaviorMonitoring" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableOnAccessProtection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableScanOnRealtimeEnable" -Type DWord -Value 1
    Write-Host "Disabled Windows Defender"
    $WPFd18.IsChecked = $false
    }
        If ( $WPFd19.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Type DWord -Value 2
    Write-Host "Disabled Windows Defender Cloud"
    $WPFd19.IsChecked = $false
    }
        If ( $WPFd20.IsChecked -eq $true ) {
    bcdedit /set `{current`} bootmenupolicy Standard | Out-Null
    Write-Host "Disabled F8 Boot Menu Options"
    $WPFd20.IsChecked = $false
    }
        If ( $WPFd21.IsChecked -eq $true ) {
    Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces\Tcpip*" -Name "NetbiosOptions" -Type DWord -Value 2
    Write-Host "Disabled NetBIOS over TCP/IP"
    $WPFd21.IsChecked = $false
    }
        If ( $WPFd22.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -Type DWord -Value 0
    Write-Host "Disabled Internet Connection Sharing"
    $WPFd22.IsChecked = $false
    }
        If ( $WPFd23.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray" -Type DWord -Value 1
    If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
    } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
    }
    Write-Host "Hide Windows Defender SysTray Icon"
    $WPFd23.IsChecked = $false
    }
        If ( $WPFd24.IsChecked -eq $true ) {
    Takeown-Registry("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend")
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "Start" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "AutorunsDisabled" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "Start" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "AutorunsDisabled" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "Start" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "AutorunsDisabled" 3
    Write-Host "Disabled Windows Defender Services"
    $WPFd24.IsChecked = $false
    }
        If ( $WPFd25.IsChecked -eq $true ) {
    Set-MpPreference -EnableControlledFolderAccess Enabled -ErrorAction SilentlyContinue
    Write-Host "Enabled Controlled Folder Access"
    $WPFd25.IsChecked = $false
    }
        If ( $WPFd26.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity")) {
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Type DWord -Value 1
    Write-Host "Enabled Core Isolation Memory Integrity"
    $WPFd26.IsChecked = $false
    }
        If ( $WPFd27.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -online -FeatureName "Windows-Defender-ApplicationGuard" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Enabled Windows Defender Application Guard"
    $WPFd27.IsChecked = $false
    }
        If ( $WPFd28.IsChecked -eq $true ) {
    Remove-ItemProperty "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -ErrorAction SilentlyContinue
    Write-Host "Show Account Protection Warning"
    $WPFd28.IsChecked = $false
    }
        If ( $WPFd29.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -ErrorAction SilentlyContinue        
    Write-Host "Enabled Block of Downloaded Files"
    $WPFd29.IsChecked = $false
    }
        If ( $WPFd30.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings" -Name "Enabled" -ErrorAction SilentlyContinue
    Write-Host "Enabled Windows Script Host"
    $WPFd30.IsChecked = $false
    }
        If ( $WPFd31.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Type DWord -Value 1
    Write-Host "Enabled .NET Strong Cryptography"
    $WPFd31.IsChecked = $false
    }
        If ( $WPFd32.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat" -Name "cadca5fe-87d3-4b96-b7fb-a231484277cc" -Type DWord -Value 0
    Write-Host "Enabled Meltdown (CVE-2017-5754) Compatibility Flag"
    $WPFd32.IsChecked = $false
    }
        If ( $WPFd33.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 5
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 1
    Write-Host "Maximum UAC Level"
    $WPFd33.IsChecked = $false
    }
        If ( $WPFd34.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Type DWord -Value 1
    Write-Host "Enabled Share Mapped Drives Between Users"
    $WPFd34.IsChecked = $false
    }
        If ( $WPFd35.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "AutoShareWks" -ErrorAction SilentlyContinue
    Write-Host "Enabled Implicit Administrative Shares"
    $WPFd35.IsChecked = $false
    }
        If ( $WPFd36.IsChecked -eq $true ) {
    Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
    Write-Host "Enabled SMB Server"
    $WPFd36.IsChecked = $false
    }
        If ( $WPFd37.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -ErrorAction SilentlyContinue
    Write-Host "Enabled LLMNR"
    $WPFd37.IsChecked = $false
    }
        If ( $WPFd38.IsChecked -eq $true ) {
    Set-NetConnectionProfile -NetworkCategory Public
    Write-Host "Set Current Network Profile to Public"
    $WPFd38.IsChecked = $false
    }
        If ( $WPFd39.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24" -Name "Category" -ErrorAction SilentlyContinue
    Write-Host "Set Unknown Networks Profile to Public"
    $WPFd39.IsChecked = $false
    }
        If ( $WPFd40.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" -Name "AutoSetup" -ErrorAction SilentlyContinue
    Write-Host "Enabled Automatic Installation of Network Devices"
    $WPFd40.IsChecked = $false
    }
        If ( $WPFd41.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" -Name "EnableFirewall" -ErrorAction SilentlyContinue
    Write-Host "Enabled Firewall"
    $WPFd41.IsChecked = $false
    }
        If ( $WPFd42.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction SilentlyContinue
    If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
    } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
    }
    Write-Host "Enabled Windows Defender"
    $WPFd42.IsChecked = $false
    }
        If ( $WPFd43IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpynetReporting" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -ErrorAction SilentlyContinue
    Write-Host "Enabled Windows Defender Cloud"
    $WPFd43IsChecked.IsChecked = $false
    }
        If ( $WPFd44.IsChecked -eq $true ) {
    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
    Write-Host "Enabled F8 Boot Menu Options"
    $WPFd44.IsChecked = $false
    }
        If ( $WPFd45.IsChecked -eq $true ) {
    Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces\Tcpip*" -Name "NetbiosOptions" -Type DWord -Value 0
    Write-Host "Enabled NetBIOS over TCP/IP"
    $WPFd45.IsChecked = $false
    }
        If ( $WPFd46.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name "NC_ShowSharedAccessUI" -ErrorAction SilentlyContinue
    Write-Host "Enabled Internet Connection Sharing"
    $WPFd46.IsChecked = $false
    }
        If ( $WPFd47.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" -Name "HideSystray" -ErrorAction SilentlyContinue
    If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
    } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063 -And [System.Environment]::OSVersion.Version.Build -le 17134) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "%ProgramFiles%\Windows Defender\MSASCuiL.exe"
    } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 17763) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -Type ExpandString -Value "%windir%\system32\SecurityHealthSystray.exe"
    }
    Write-Host "Show Windows Defender SysTray"
    $WPFd46.IsChecked = $false
    }
        If ( $WPFd48.IsChecked -eq $true ) {
    Takeown-Registry("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend")
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "Start" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend" "AutorunsDisabled" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "Start" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WdNisSvc" "AutorunsDisabled" 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "Start" 3
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sense" "AutorunsDisabled" 4
    Write-Host "Enabled Windows Defender Services"
    $WPFd46.IsChecked = $false
    }

    Write-Host "All Selected Tweaks are activated successfully"
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Update ####################
##########################################

$WPFTab7P1.Add_Click({
    $WPFu1.IsChecked = $false
    $WPFu2.IsChecked = $false
    $WPFu3.IsChecked = $false
    $WPFu4.IsChecked = $false
    $WPFu5.IsChecked = $false
    $WPFu6.IsChecked = $false
    $WPFu7.IsChecked = $false
    $WPFu8.IsChecked = $false
    $WPFu9.IsChecked = $false
    $WPFu10.IsChecked = $true
    $WPFu11.IsChecked = $true
    $WPFu12.IsChecked = $true
    $WPFu13.IsChecked = $true
    $WPFu14.IsChecked = $true
    $WPFu15.IsChecked = $true
    $WPFu16.IsChecked = $true
    $WPFu17.IsChecked = $true
    $WPFu18.IsChecked = $true

})

$WPFTab7P2.Add_Click({
    $WPFu1.IsChecked = $true
    $WPFu2.IsChecked = $true
    $WPFu3.IsChecked = $false
    $WPFu4.IsChecked = $false
    $WPFu5.IsChecked = $true
    $WPFu6.IsChecked = $false
    $WPFu7.IsChecked = $true
    $WPFu8.IsChecked = $true
    $WPFu9.IsChecked = $true
    $WPFu10.IsChecked = $false
    $WPFu11.IsChecked = $false
    $WPFu12.IsChecked = $false
    $WPFu13.IsChecked = $false
    $WPFu14.IsChecked = $false
    $WPFu15.IsChecked = $false
    $WPFu16.IsChecked = $false
    $WPFu17.IsChecked = $false
    $WPFu18.IsChecked = $false

})

$WPFTab7P3.Add_Click({
    $WPFu1.IsChecked = $true
    $WPFu2.IsChecked = $true
    $WPFu3.IsChecked = $true
    $WPFu4.IsChecked = $true
    $WPFu5.IsChecked = $true
    $WPFu6.IsChecked = $true
    $WPFu7.IsChecked = $true
    $WPFu8.IsChecked = $true
    $WPFu9.IsChecked = $true
    $WPFu10.IsChecked = $false
    $WPFu11.IsChecked = $false
    $WPFu12.IsChecked = $false
    $WPFu13.IsChecked = $false
    $WPFu14.IsChecked = $false
    $WPFu15.IsChecked = $false
    $WPFu16.IsChecked = $false
    $WPFu17.IsChecked = $false
    $WPFu18.IsChecked = $false

})

$WPFTab7P4.Add_Click({

        If ( $WPFu1.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -Type DWord -Value 0
    Write-Host "Disabled Nightly Wake-Up for Automatic Maintenance"
    $WPFu1.IsChecked = $false
    }
        If ( $WPFu2.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Type DWord -Value 2
    }
    Write-Host "Disabled Windows Update Automatic Downloads"
    $WPFu2.IsChecked = $false
    }
        If ( $WPFu3.IsChecked -eq $true ) {
    If ((New-Object -ComObject Microsoft.Update.ServiceManager).Services | Where-Object { $_.ServiceID -eq "7971f918-a847-4430-9279-4a52d1efe18d"}) {
    (New-Object -ComObject Microsoft.Update.ServiceManager).RemoveService("7971f918-a847-4430-9279-4a52d1efe18d") | Out-Null
    }
    Write-Host "Disabled Updates for Other Microsoft Products"
    $WPFu3.IsChecked = $false
    }
        If ( $WPFu4.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -Type DWord -Value 1
    Write-Host "Disabled Malicious Software Removal Tool Offering"
    $WPFu4.IsChecked = $false
    }
        If ( $WPFu5.IsChecked -eq $true ) {
    If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
    # Method used in 1507
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
    # Method used in 1511 and 1607
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 1
    } Else {
    # Method used since 1703
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
    }
    Write-Host "Restrict Windows Update P2P Optimization to Local Network"
    $WPFu5.IsChecked = $false
    }
        If ( $WPFu6.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabled Driver Download from Windows Update"
    $WPFu6.IsChecked = $false
    }
        If ( $WPFu7.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -Type String -Value "cmd.exe"
    Write-Host "Disabled Windows Update Automatic Restart"
    $WPFu7.IsChecked = $false
    }
        If ( $WPFu8.IsChecked -eq $true ) {
    takeown /F "$env:WinDIR\System32\MusNotification.exe"
    icacls "$env:WinDIR\System32\MusNotification.exe" /deny "$($EveryOne):(X)"
    takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
    icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "$($EveryOne):(X)"
    Write-Host "Disabled Update Notifications"
    $WPFu8.IsChecked = $false
    }
        If ( $WPFu9.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Only Security Update"
    $WPFu9.IsChecked = $false
    }
        If ( $WPFu10.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" -Name "WakeUp" -ErrorAction SilentlyContinue
    Write-Host "Enabled Nightly Wake-Up for Automatic Maintenance"
    $WPFu10.IsChecked = $false
    }
        If ( $WPFu11.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -ErrorAction SilentlyContinue
    Write-Host "Enabled Windows Update Automatic Downloads"
    $WPFu11.IsChecked = $false
    }
        If ( $WPFu12.IsChecked -eq $true ) {
    (New-Object -ComObject Microsoft.Update.ServiceManager).AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "") | Out-Null
    Write-Host "Enabled Updates for Other Microsoft Products"
    $WPFu12.IsChecked = $false
    }
        If ( $WPFu13.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontOfferThroughWUAU" -ErrorAction SilentlyContinue
    Write-Host "Enabled Malicious Software Removal Tool Offering"
    $WPFu13.IsChecked = $false
    }
    If ( $WPFu14.IsChecked -eq $true ) {
    If ([System.Environment]::OSVersion.Version.Build -eq 10240) {
    # Method used in 1507
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 3
    } ElseIf ([System.Environment]::OSVersion.Version.Build -le 14393) {
    # Method used in 1511 and 1607
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
    } Else {
    # Method used since 1703
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 3
    }
    Write-Host "Unrestrict Windows Update P2P Optimization to Local Network"
    $WPFu14.IsChecked = $false
    }
        If ( $WPFu15.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "SearchOrderConfig" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue  
    Write-Host "Enabled Driver Download from Windows Update"
    $WPFu15.IsChecked = $false
    }
        If ( $WPFu16.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" -Name "Debugger" -ErrorAction SilentlyContinue
    Write-Host "Enabled Windows Update Automatic Restart"
    $WPFu16.IsChecked = $false
    }
        If ( $WPFu17.IsChecked -eq $true ) {
    takeown /F "$env:WinDIR\System32\MusNotification.exe"
    icacls "$env:WinDIR\System32\MusNotification.exe" /allow "$($EveryOne):(X)"
    takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
    icacls "$env:WinDIR\System32\MusNotificationUx.exe" /allow "$($EveryOne):(X)"
    Write-Host "Enabled Update Notifications"
    $WPFu17.IsChecked = $false
    }
        If ( $WPFu18.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue
    Write-Host "Default Windows Update"
    $WPFu18.IsChecked = $false
    }

    Write-Host "All Selected Tweaks are activated successfully"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Application ###############
##########################################

$WPFTab8P1.Add_Click({
    $WPFa1.IsChecked = $true
    $WPFa2.IsChecked = $true
    $WPFa3.IsChecked = $true
    $WPFa4.IsChecked = $true
    $WPFa5.IsChecked = $false
    $WPFa6.IsChecked = $true
    $WPFa7.IsChecked = $false
    $WPFa8.IsChecked = $true
    $WPFa9.IsChecked = $true
    $WPFa10.IsChecked = $true
    $WPFa11.IsChecked = $true
    $WPFa12.IsChecked = $true
    $WPFa13.IsChecked = $true
    $WPFa14.IsChecked = $false
    $WPFa15.IsChecked = $false
    $WPFa16.IsChecked = $true
    $WPFa17.IsChecked = $true
    $WPFa18.IsChecked = $false
    $WPFa19.IsChecked = $false
    $WPFa20.IsChecked = $true
    $WPFa21.IsChecked = $false
    $WPFa22.IsChecked = $false
    $WPFa23.IsChecked = $true
    $WPFa24.IsChecked = $false
    $WPFa25.IsChecked = $false
    $WPFa26.IsChecked = $false
    $WPFa27.IsChecked = $false
    $WPFa28.IsChecked = $false
    $WPFa29.IsChecked = $false
    $WPFa30.IsChecked = $false
    $WPFa31.IsChecked = $false
    $WPFa32.IsChecked = $false
    $WPFa33.IsChecked = $false
    $WPFa34.IsChecked = $false
    $WPFa35.IsChecked = $false
    $WPFa36.IsChecked = $false
    $WPFa37.IsChecked = $false

})

$WPFTab8P2.Add_Click({

        If ( $WPFa1.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
    Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
    $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Remove OneDrive"
    $WPFa1.IsChecked = $false
    }
        If ( $WPFa2.IsChecked -eq $true ) {
    Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Windows Media Player"
    $WPFa2.IsChecked = $false
    }
        If ( $WPFa3.IsChecked -eq $true ) {
    Disable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-$env:PROCESSOR_ARCHITECTURE" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Internet Explorer"
    $WPFa3.IsChecked = $false
    }
        If ( $WPFa4.IsChecked -eq $true ) {
    Disable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled Work Folders"
    $WPFa4.IsChecked = $false
    }
        If ( $WPFa5.IsChecked -eq $true ) {
    If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 0
    }
    Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Disabled WSL (Linux Subsystem)"
    $WPFa5.IsChecked = $false
    }
        If ( $WPFa6.IsChecked -eq $true ) {
    If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
    Uninstall-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
    } Else {
    Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
    Write-Host "Disabled Hyper-V"
    $WPFa6.IsChecked = $false
    }
        If ( $WPFa7.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Remove PhotoViewer from Context Menu"
    $WPFa7.IsChecked = $false
    }
        If ( $WPFa8.IsChecked -eq $true ) {
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Remove Microsoft Print to PDF"
    $WPFa8.IsChecked = $false
    }
        If ( $WPFa9.IsChecked -eq $true ) {
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Remove Microsoft XPS Document Writer"
    $WPFa9.IsChecked = $false
    }
        If ( $WPFa10.IsChecked -eq $true ) {
    Remove-Printer -Name "Fax" -ErrorAction SilentlyContinue
    Write-Host "Remove Fax Printer"
    $WPFa10.IsChecked = $false
    }
        If ( $WPFa11.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -ErrorAction SilentlyContinue
    Write-Host "Remove Developer Mode"
    $WPFa11.IsChecked = $false
    }
        If ( $WPFa12.IsChecked -eq $true ) {
    Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Remove-WindowsCapability -Online | Out-Null
    Write-Host "Remove Math Recognizer"
    $WPFa12.IsChecked = $false
    }
        If ( $WPFa13.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "BackupPolicy" 0x3c
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "DeviceMetadataUploaded" 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "PriorLogons" 1
    $groups = @(
    "Accessibility"
    "AppSync"
    "BrowserSettings"
    "Credentials"
    "DesktopTheme"
    "Language"
    "PackageState"
    "Personalization"
    "StartLayout"
    "Windows"
    )
    foreach ($group in $groups) {
    New-FolderForced -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" "Enabled" 0
    }     
    Write-Host "Disabled Setting Sync"
    $WPFa13.IsChecked = $false
    }
        If ( $WPFa14.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\wlidsvc" -Name Start -Type "DWORD" -Value 4 -Force
    Set-Service wlidsvc -StartupType Disabled
    Write-Host "Disabled Windows Live ID Service"
    $WPFa14.IsChecked = $false
    }
        If ( $WPFa15.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
    Write-Host "Performance Settings FX"
    $WPFa15.IsChecked = $false
    }
        If ( $WPFa16.IsChecked -eq $true ) {
    Stop-Process -Force -Force -Name  ccleaner.exe
    Stop-Process -Force -Force -Name  ccleaner64.exe
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HomeScreen" -Type "String" -Value 2 -Force
    Stop-Process -Force -Force -Name "IMAGENAME eq CCleaner*"
    schtasks /Change /TN "CCleaner Update" /Disable
    Get-ScheduledTask -TaskName "CCleaner Update" | Disable-ScheduledTask
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "Monitoring" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "HelpImproveCCleaner" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "SystemMonitoring" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateAuto" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "UpdateCheck" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Piriform\CCleaner" -Name "CheckTrialOffer" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)HealthCheck" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickClean" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)QuickCleanIpm" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)GetIpmForTrial" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdater" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)SoftwareUpdaterIpm" -Type "DWORD" -Value 0 -Force
    Write-Host "Disabled CCleaner Telemetry"
    $WPFa16.IsChecked = $false
    }
        If ( $WPFa17.IsChecked -eq $true ) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableLogging" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE
    schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE
    schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE
    schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Force
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
    Write-Host "Disabled Office Telemetry"
    $WPFa17.IsChecked = $false
    }
        If ( $WPFa18.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Adobe\Adobe ARM\1.0\ARM" -Name "iCheck" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown" -Name "cSharePoint" -Type "String" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bToggleAdobeDocumentServices" -Type "String" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bToggleAdobeSign" -Type "String" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bTogglePrefSync" -Type "String" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bToggleWebConnectors" -Type "String" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bAdobeSendPluginToggle" -Type "String" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Acrobat Reader\DC\FeatureLockdown\cServices" -Name "bUpdater" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Adobe\Adobe ARM\1.0\ARM" -Name "iCheck" -Type "String" -Value 0 -Force
    Set-Service "Adobe Acrobat Update Task" -StartupType Disabled
    Set-Service "Adobe Flash Player Updater" -StartupType Disabled
    Set-Service "adobeflashplayerupdatesvc" -StartupType Disabled
    Set-Service "adobeupdateservice" -StartupType Disabled
    Set-Service "AdobeARMservice" -StartupType Disabled
    Write-Host "Disabled Adobe Telemetry"
    $WPFa18.IsChecked = $false
    }
        If ( $WPFa19.IsChecked -eq $true ) {
    Set-Service dbupdate -StartupType Disabled
    Set-Service dbupdatem -StartupType Disabled
    Get-ScheduledTask -TaskName "DropboxUpdateTaskMachineCore" | Disable-ScheduledTask
    Get-ScheduledTask -TaskName "DropboxUpdateTaskMachineUA" | Disable-ScheduledTask
    #schtasks /Change /TN "DropboxUpdateTaskMachineCore" /Disable
    #schtasks /Change /TN "DropboxUpdateTaskMachineUA" /Disable
    Write-Host "Disabled Dropbox Telemetry"
    $WPFa19.IsChecked = $false
    }
        If ( $WPFa20.IsChecked -eq $true ) {
    Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineCore" | Disable-ScheduledTask
    Get-ScheduledTask -TaskName "GoogleUpdateTaskMachineUA" | Disable-ScheduledTask
    #schtasks /Change /TN "GoogleUpdateTaskMachineCore" /Disable
    #schtasks /Change /TN "GoogleUpdateTaskMachineUA" /Disable
    Write-Host "Disabled Google Update Service"
    $WPFa20.IsChecked = $false
    }
        If ( $WPFa21.IsChecked -eq $true ) {
    Stop-Service "LogiRegistryService"
    Set-Service "LogiRegistryService" -StartupType Disabled
    Write-Host "Disabled Logitech Telemetry"
    $WPFa21.IsChecked = $false
    }
        If ( $WPFa22.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\14.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\15.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\VSCommon\16.0\SQM" -Name "OptIn" -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\14.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\15.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\VSCommon\16.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\14.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\15.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\VSCommon\16.0\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\VisualStudio\SQM" -Name OptIn -Type "DWORD" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\VisualStudio\Telemetry" -Name TurnOffSwitch -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableFeedbackDialog" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableEmailInput" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\VisualStudio\Feedback" -Name "DisableScreenshotCapture" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\VisualStudio\Telemetry" -Name "TurnOffSwitch" -Type "DWORD" -Value 1 -Force
    Stop-Service "VSStandardCollectorService150"
    Set-Service "VSStandardCollectorService150" -StartupType Disabled
    Write-Host "Disabled Vs Code Telemetry"
    $WPFa22.IsChecked = $false
    }
        If ( $WPFa23.IsChecked -eq $true ) {
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "DisallowRun" -Type "DWORD" -Value 1 -Force
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" -Name "1" -Type "String" -Value "software_reporter_tool.exe" /f
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\software_reporter_tool.exe" -Name Debugger -Type "String" -Value "%windir%\System32\taskkill.exe" -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Type "String" -Value 0 -Force
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Type "String" -Value 0 -Force
    Write-Host "Disabled Chrome Telemetry"
    $WPFa23.IsChecked = $false
    }
        If ( $WPFa24.IsChecked -eq $true ) {
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
	If (!(Test-Path $onedrive)) {
    $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
	}
	Start-Process $onedrive -NoNewWindow
    Write-Host "Reinstall OneDrive"
    $WPFa24.IsChecked = $false
    }
        If ( $WPFa25.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Reactive Windows Media Player"
    $WPFa25.IsChecked = $false
    }
        If ( $WPFa26.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-$env:PROCESSOR_ARCHITECTURE" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Reactive Internet Explorer"
    $WPFa26.IsChecked = $false
    }
        If ( $WPFa27.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Reactive Work Folders"
    $WPFa27.IsChecked = $false
    }
        If ( $WPFa28.IsChecked -eq $true ) {
    If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
    # 1607 needs developer mode to be enabled
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 1
    }
    Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Reactive WSL (Linux Subsystem)"
    $WPFa28.IsChecked = $false
    }
        If ( $WPFa29.IsChecked -eq $true ) {
    If ((Get-WmiObject -Class "Win32_OperatingSystem").Caption -like "*Server*") {
    Install-WindowsFeature -Name "Hyper-V" -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
    } Else {
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
    Enable-WindowsOptionalFeature -Online -FeatureName "HypervisorPlatform" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Tools-All" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-PowerShell" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Services" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-Clients" -All
    cmd /c bcdedit /set hypervisorschedulertype classic
    Write-Host "Reactive Hyper-V"
    $WPFa29.IsChecked = $false
    }
        If ( $WPFa30.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    New-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Force | Out-Null
    New-Item -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Force | Out-Null
    Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open" -Name "MuiVerb" -Type String -Value "@photoviewer.dll,-3043"
    Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Name "(Default)" -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
    Set-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Name "Clsid" -Type String -Value "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"
    Write-Host "Add PhotoViewer to Context Menu"
    $WPFa30.IsChecked = $false
    }
        If ( $WPFa31.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Add Microsoft Print to PDF"
    $WPFa31.IsChecked = $false
    }
        If ( $WPFa32.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart -WarningAction SilentlyContinue | Out-Null
    Write-Host "Add Microsoft XPS Document Writer"
    $WPFa32.IsChecked = $false
    }
        If ( $WPFa33.IsChecked -eq $true ) {
    Add-Printer -Name "Fax" -DriverName "Microsoft Shared Fax Driver" -PortName "SHRFAX:" -ErrorAction SilentlyContinue
    Write-Host "Add Fax Printer"
    $WPFa33.IsChecked = $false
    }
        If ( $WPFa34.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 1
    Write-Host "Add Developer Mode"
    $WPFa34.IsChecked = $false
    }
        If ( $WPFa35.IsChecked -eq $true ) {
    Get-WindowsCapability -Online | Where-Object { $_.Name -like "MathRecognizer*" } | Add-WindowsCapability -Online | Out-Null
    Write-Host "Add Math Recognizer"
    $WPFa35.IsChecked = $false
    }
        If ( $WPFa36.IsChecked -eq $true ) {
    Enable-WindowsOptionalFeature -Online -FeatureName "ServicesForNFS-ClientOnly" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "ClientForNFS-Infrastructure" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "NFS-Administration" -All
	nfsadmin client stop
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUID" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGID" -Type DWord -Value 0
    nfsadmin client start
    nfsadmin client localhost config fileaccess=755 SecFlavors=+sys -krb5 -krb5i
    Write-Host "Enabled NFS"
    $WPFa36.IsChecked = $false
    }
        If ( $WPFa37.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 400
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
    Write-Host "Graphic Settings FX"
    $WPFa37.IsChecked = $false
    }

    Write-Host "All Selected Tweaks are activated successfully"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## System ####################
##########################################

$WPFTab9P1.Add_Click({
    $WPFe1.IsChecked = $true
    $WPFe2.IsChecked = $true
    $WPFe3.IsChecked = $false
    $WPFe4.IsChecked = $false
    $WPFe5.IsChecked = $true
    $WPFe6.IsChecked = $false
    $WPFe7.IsChecked = $false
    $WPFe8.IsChecked = $true
    $WPFe9.IsChecked = $false
    $WPFe10.IsChecked = $false
    $WPFe11.IsChecked = $false
    $WPFe12.IsChecked = $true
    $WPFe13.IsChecked = $false
    $WPFe14.IsChecked = $false
    $WPFe15.IsChecked = $false
    $WPFe16.IsChecked = $false
    $WPFe17.IsChecked = $false
    $WPFe18.IsChecked = $false
    $WPFe19.IsChecked = $true
    $WPFe20.IsChecked = $true
    $WPFe21.IsChecked = $false
    $WPFe22.IsChecked = $false
    $WPFe23.IsChecked = $false
    $WPFe24.IsChecked = $false
    $WPFe25.IsChecked = $false
    $WPFe26.IsChecked = $false
    $WPFe27.IsChecked = $false
    $WPFe28.IsChecked = $false
    $WPFe29.IsChecked = $true
    $WPFe30.IsChecked = $false
    $WPFe31.IsChecked = $false
    $WPFe32.IsChecked = $false
    $WPFe33.IsChecked = $true
    $WPFe34.IsChecked = $true
    $WPFe35.IsChecked = $false
    $WPFe36.IsChecked = $true
    $WPFe37.IsChecked = $true
    $WPFe38.IsChecked = $true
    $WPFe39.IsChecked = $false
    $WPFe40.IsChecked = $false
    $WPFe41.IsChecked = $false
    $WPFe42.IsChecked = $false
    $WPFe43.IsChecked = $false
    $WPFe44.IsChecked = $false
    $WPFe45.IsChecked = $false
    $WPFe46.IsChecked = $false

})

$WPFTab9P2.Add_Click({

        If ( $WPFe1.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0       
    Write-Host "Showed known File Extensions"
    $WPFe1.IsChecked = $false
    }
        If ( $WPFe2.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1
    Write-Host "Showed Hidden Files"
    $WPFe2.IsChecked = $false
    }
        If ( $WPFe3.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 1
    Write-Host "Showed Protected Operating System Files"
    $WPFe3.IsChecked = $false
    }
        If ( $WPFe4.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Type DWord -Value 0
    Write-Host "Showed Empty Drives (With no Media)"
    $WPFe4.IsChecked = $false
    }
        If ( $WPFe5.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -Type DWord -Value 0
    Write-Host "Showed Folder Merge Conflicts"
    $WPFe5.IsChecked = $false
    }
        If ( $WPFe6.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -Type DWord -Value 1
    Write-Host "Enabled Navigation Panel Expand to Current Folder"
    $WPFe6.IsChecked = $false
    }
        If ( $WPFe7.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SeparateProcess" -Type DWord -Value 1
    Write-Host "Enabled Launching Folder in a Separate Process"
    $WPFe7.IsChecked = $false
    }
        If ( $WPFe8.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -Type DWord -Value 1
    Write-Host "Enabled Restoring Previous Folder at Logon"
    $WPFe8.IsChecked = $false
    }
        If ( $WPFe9.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowEncryptCompressedColor" -Type DWord -Value 1
    Write-Host "Showed Coloring of Encrypted or Compressed NTFS Files"
    $WPFe9.IsChecked = $false
    }
        If ( $WPFe10.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -ErrorAction SilentlyContinue
    Write-Host "Enabled Sharing Wizard"
    $WPFe10.IsChecked = $false
    }
        If ( $WPFe11.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 1
    Write-Host "Showed Checkbox"
    $WPFe11.IsChecked = $false
    }
        If ( $WPFe12.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 1
    Write-Host "Showed Sync Provider Notifications"
    $WPFe12.IsChecked = $false
    }
        If ( $WPFe13.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    New-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -Name "(Default)" -Type String -Value "{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"
    Write-Host "Showed 'Include in Library' in Context Menu"
    $WPFe13.IsChecked = $false
    }
        If ( $WPFe14.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    New-Item -Path "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
    New-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
    New-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"
    New-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -Name "(Default)" -Type String -Value "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"    
    Write-Host "Showed 'Give Access to' in Context Menu"
    $WPFe14.IsChecked = $false
    }
        If ( $WPFe15.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    New-Item -Path "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue | Out-Null
    Set-ItemProperty -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -Name "(Default)" -Type String -Value "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"
    Write-Host "Showed 'Share' in Context Menu"
    $WPFe15.IsChecked = $false
    }
        If ( $WPFe16.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Type DWord -Value 0
    Write-Host "Enabled Thumbnails"
    $WPFe16.IsChecked = $false
    }
        If ( $WPFe17.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -ErrorAction SilentlyContinue
    Write-Host "Enabled Creation of Thumbnail Cache Files"
    $WPFe17.IsChecked = $false
    }
        If ( $WPFe18.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbsDBOnNetworkFolders" -ErrorAction SilentlyContinue
    Write-Host "Enabled Creation of Thumbs.db on Network Folders"
    $WPFe18.IsChecked = $false
    }
        If ( $WPFe19.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -ErrorAction SilentlyContinue
    Write-Host "Showed Recycle Bin Shorcut on Desktop"
    $WPFe19.IsChecked = $false
    }
        If ( $WPFe20.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Type DWord -Value 0
    Write-Host "Showed This PC Shorcut on Desktop"
    $WPFe20.IsChecked = $false
    }
        If ( $WPFe21.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -Type DWord -Value 0
    Write-Host "Showed User Folder Shorcut on Desktop"
    $WPFe21.IsChecked = $false
    }
        If ( $WPFe22.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -Type DWord -Value 0
    Write-Host "Showed Control Panel Shorcut on Desktop"
    $WPFe22.IsChecked = $false
    }
        If ( $WPFe23.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" )) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"  -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" )) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 0
    Write-Host "Showed Network Shorcut on Desktop"
    $WPFe23.IsChecked = $false
    }
        If ( $WPFe24.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1
    Write-Host "Hided known File Extensions"
    $WPFe24.IsChecked = $false
    }
        If ( $WPFe25.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 2
    Write-Host "Hided Hidden Files"
    $WPFe25.IsChecked = $false
    }
        If ( $WPFe26.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 0
    Write-Host "Hided Protected Operating System Files"
    $WPFe26.IsChecked = $false
    }
        If ( $WPFe27.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -ErrorAction SilentlyContinue
    Write-Host "Hided Empty Drives (With no Media)"
        $WPFe27.IsChecked = $false
    }
        If ( $WPFe28.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideMergeConflicts" -ErrorAction SilentlyContinue
    Write-Host "Hided Foldeer Merge Conflicts"
    $WPFe28.IsChecked = $false
    }
        If ( $WPFe29.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -ErrorAction SilentlyContinue
    Write-Host "Disabled Navigation Panel Expand to Current Folder"
    $WPFe29.IsChecked = $false
    }
        If ( $WPFe30.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SeparateProcess" -Type DWord -Value 0
    Write-Host "Disabled Launching Folder in a Separate Process"
    $WPFe30.IsChecked = $false
    }
        If ( $WPFe31.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "PersistBrowsers" -ErrorAction SilentlyContinue
    Write-Host "Disabled Restoring Previous Folder at Logon"
    $WPFe31.IsChecked = $false
    }
        If ( $WPFe32.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowEncryptCompressedColor" -ErrorAction SilentlyContinue
    Write-Host "Hided Coloring of Encrypted or Compressed NTFS Files"
    $WPFe32.IsChecked = $false
    }
        If ( $WPFe33.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SharingWizardOn" -Type DWord -Value 0
    Write-Host "Disabled Sharing Wizard"
    $WPFe33.IsChecked = $false
    }
        If ( $WPFe34.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Type DWord -Value 0
    Write-Host "Hided Checkbox"
    $WPFe34.IsChecked = $false
    }
        If ( $WPFe35.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 0
    Write-Host "Hided Sync Provider Notifications"
    $WPFe35.IsChecked = $false
    }
        If ( $WPFe36.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -ErrorAction SilentlyContinue    
    Write-Host "Hided 'Include in Library"
    $WPFe36.IsChecked = $false
    }
        If ( $WPFe37.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\Sharing" -ErrorAction SilentlyContinue    
    Write-Host "Hided 'Give Access to' in Context Menu"
    $WPFe37.IsChecked = $false
    }
        If ( $WPFe38.IsChecked -eq $true ) {
    If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name "HKCR" -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" | Out-Null
    }
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -ErrorAction SilentlyContinue   
    Write-Host "Hided 'Share' in Context Menu"
    $WPFe38.IsChecked = $false
    }
        If ( $WPFe39.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Type DWord -Value 1
    Write-Host "Disabled Thumbnails"
    $WPFe39.IsChecked = $false
    }
        If ( $WPFe40.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -Type DWord -Value 1
    Write-Host "Disabled Creation of Thumbnail Cache Files"
    $WPFe40.IsChecked = $false
    }
        If ( $WPFe41.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbsDBOnNetworkFolders" -Type DWord -Value 1
    Write-Host "Disabled Creation of Thumbs.db on Network Folders"
    $WPFe41.IsChecked = $false
    }
        If ( $WPFe42.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
    Write-Host "Hided Recycle Bin Shorcut from Desktop"
    $WPFe42.IsChecked = $false
    }
        If ( $WPFe43IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -ErrorAction SilentlyContinue
    Write-Host "Hided This PC Shorcut on Desktop"
    $WPFe43IsChecked.IsChecked = $false
    }
        If ( $WPFe44.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" -ErrorAction SilentlyContinue
    Write-Host "Hided User Folder Shorcut on Desktop"
    $WPFe44.IsChecked = $false
    }
        If ( $WPFe45.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" -ErrorAction SilentlyContinue
    Write-Host "Hided Control Panel Shorcut on Desktop"
    $WPFe45.IsChecked = $false
    }
        If ( $WPFe46.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -ErrorAction SilentlyContinue
    Write-Host "Hided Network Shorcut on Desktop"
    $WPFe46.IsChecked = $false
    }

    Write-Host "All Selected Tweaks are activated successfully"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Explorer ##################
##########################################

$WPFTab10P1.Add_Click({
    $WPFed1.IsChecked = $true
    $WPFed2.IsChecked = $false
    $WPFed3.IsChecked = $false
    $WPFed4.IsChecked = $false
    $WPFed5.IsChecked = $false
    $WPFed6.IsChecked = $false
    $WPFed7.IsChecked = $false
    $WPFed8.IsChecked = $false
    $WPFed9.IsChecked = $false
    $WPFed10.IsChecked = $true
    $WPFed11.IsChecked = $false
    $WPFed12.IsChecked = $false
    $WPFed13.IsChecked = $true
    $WPFed14.IsChecked = $false
    $WPFed15.IsChecked = $false
    $WPFed16.IsChecked = $false
    $WPFed17.IsChecked = $false
    $WPFed18.IsChecked = $false
    $WPFed19.IsChecked = $false
    $WPFed20.IsChecked = $false
    $WPFed21.IsChecked = $false
    $WPFed22.IsChecked = $false
    $WPFed23.IsChecked = $false
    $WPFed24.IsChecked = $false
    $WPFed25.IsChecked = $false
    $WPFed26.IsChecked = $false
    $WPFed27.IsChecked = $false
    $WPFed28.IsChecked = $false
    $WPFed29.IsChecked = $false
    $WPFed30.IsChecked = $false
    $WPFed31.IsChecked = $false
    $WPFed32.IsChecked = $false
    $WPFed33.IsChecked = $false
    $WPFed34.IsChecked = $false
    $WPFed35.IsChecked = $false
    $WPFed36.IsChecked = $false
    $WPFed37.IsChecked = $true
    $WPFed38.IsChecked = $false
    $WPFed39.IsChecked = $false
    $WPFed40.IsChecked = $false
    $WPFed41.IsChecked = $false
    $WPFed42.IsChecked = $false
    $WPFed43.IsChecked = $false
    $WPFed44.IsChecked = $false

})

$WPFTab10P2.Add_Click({

        If ( $WPFed1.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 0
    Write-Host "Showed All Icon on Desktop"
    $WPFed1.IsChecked = $false
    }
        If ( $WPFed2.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "PaintDesktopVersion" -Type DWord -Value 1
    Write-Host "Showed Windows Build Number on Desktop"
    $WPFed2.IsChecked = $false
    }
        If ( $WPFed3.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" | Out-Null
    }
    Write-Host "Showed Desktop Icon in This PC"
    $WPFed3.IsChecked = $false
    }
        If ( $WPFed4.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" | Out-Null
    }
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" | Out-Null
    }
    Write-Host "Showed Documents Icon in This PC"
    $WPFed4.IsChecked = $false
    }
        If ( $WPFed5.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" | Out-Null
    }
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" | Out-Null
    }
    Write-Host "Showed Downloads Icon in This PC"
    $WPFed5.IsChecked = $false
    }
        If ( $WPFed6.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" | Out-Null
    }
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" | Out-Null
    }
    Write-Host "Showed Music Icon in This PC"
    $WPFed6.IsChecked = $false
    }
    If ( $WPFed7.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" | Out-Null
    }
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" | Out-Null
    }
    Write-Host "Showed Pictures Icon in This PC"
    $WPFed7.IsChecked = $false
    }
    If ( $WPFed8.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" | Out-Null
    }
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" | Out-Null
    }
    Write-Host "Showed Videos Icon in This PC"
    $WPFed8.IsChecked = $false
    }
        If ( $WPFed9.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 1
    Write-Host "Showed Network Icon in This PC"
    $WPFed9.IsChecked = $false
    }
        If ( $WPFed10.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1
    Write-Host "Showed Full Directory Path in Explorer"
    $WPFed10.IsChecked = $false
    }
        If ( $WPFed11.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneShowAllFolders" -Type DWord -Value 1
    Write-Host "Showed All Folder in Explorer Navigation Panel"
    $WPFed11.IsChecked = $false
    }
        If ( $WPFed12.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -ErrorAction SilentlyContinue
    Write-Host "Showed Recent Shorcuts in Explorer"
    $WPFed12.IsChecked = $false
    }
        If ( $WPFed13.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1
    Write-Host "Change Default Explorer view to This PC"
    $WPFed13.IsChecked = $false
    }
        If ( $WPFed14.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -ErrorAction SilentlyContinue
    Write-Host "Showed Quick Access in Explorer Navigation Panel"
    $WPFed14.IsChecked = $false
    }
        If ( $WPFed15.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}")) {
    New-Item -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -Type DWord -Value 1
    Write-Host "Showed Libraries Icon in Explorer Namespace"
    $WPFed15.IsChecked = $false
    }
        If ( $WPFed16.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Write-Host "Showed Desktop Icon in Explorer Namespace"
    $WPFed16.IsChecked = $false
    }
        If ( $WPFed17.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Write-Host "Showed Documents Icon in Explorer Namespace"
    $WPFed17.IsChecked = $false
    }
        If ( $WPFed18.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Write-Host "Showed Downloads Icon in Explorer Namespace"
    $WPFed18.IsChecked = $false
    }
        If ( $WPFed19.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Write-Host "Showed Music icon in Explorer Namespace"
    $WPFed19.IsChecked = $false
    }
        If ( $WPFed20.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Write-Host "Showed Pictures Icon in Explorer Namespace"
    $WPFed20.IsChecked = $false
    }
        If ( $WPFed21.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Show"
    Write-Host "Showed Videos Icon in Explorer Namespace"
    $WPFed21.IsChecked = $false
    }
        If ( $WPFed22.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -ErrorAction SilentlyContinue
    Write-Host "Showed Network Icon in Explorer Namespace"
    $WPFed22.IsChecked = $false
    }
        If ( $WPFed23.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 1
    Write-Host "Hided All Icon on Desktop"
    $WPFed23.IsChecked = $false
    }
        If ( $WPFed24.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value 1
    Write-Host "Hided Windows Build Number on Desktop"
    $WPFed24.IsChecked = $false
    }
        If ( $WPFed25.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Hided Desktop Icon in This PC"
        $WPFed25.IsChecked = $false
    }
        If ( $WPFed26.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Hided Documents Icon in This PC"
    $WPFed26.IsChecked = $false
    }
        If ( $WPFed27.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Hided Downloads Icon in This PC"
    $WPFed27.IsChecked = $false
    }
        If ( $WPFed28.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Hided Music Icon in This PC"
    $WPFed28.IsChecked = $false
    }
        If ( $WPFed29.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Hided Pictures Icon in This PC"
    $WPFed29.IsChecked = $false
    }
        If ( $WPFed30.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Recurse -ErrorAction SilentlyContinue
    Write-Host "Hided Videos Icon in This PC"
    $WPFed30.IsChecked = $false
    }
        If ( $WPFed31.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 0
    Write-Host "Hided Network Icon in This PC"
    $WPFed31.IsChecked = $false
    }
        If ( $WPFed32.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -ErrorAction SilentlyContinue
    Write-Host "Hided Full Directory Path in Explorer"
    $WPFed32.IsChecked = $false
    }
        If ( $WPFed33.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneShowAllFolders" -ErrorAction SilentlyContinue
    Write-Host "Hided All Folder in Explorer Navigation Panel"
    $WPFed33.IsChecked = $false
    }
        If ( $WPFed34.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
    Write-Host "Hided Recent Shorcuts in Explorer"
    $WPFed34.IsChecked = $false
    }
        If ( $WPFed35.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -ErrorAction SilentlyContinue
    Write-Host "Change Default Explorer view to Quick Access"
    $WPFed35.IsChecked = $false
    }
        If ( $WPFed36.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -Type DWord -Value 1
    Write-Host "Hided Quick Access in Explorer Navigation Panel"
    $WPFed36.IsChecked = $false
    }
        If ( $WPFed37.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" -Name "System.IsPinnedToNameSpaceTree" -ErrorAction SilentlyContinue
    Write-Host "Hided Libraries Icon in Explorer Namespace"
    $WPFed37.IsChecked = $false
    }
        If ( $WPFed38.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Write-Host "Hided Desktop Icon in Explorer Namespace"
    $WPFed38.IsChecked = $false
    }
        If ( $WPFed39.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Write-Host "Hided Documents Icon in Explorer Namespace"
    $WPFed39.IsChecked = $false
    }
        If ( $WPFed40.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Write-Host "Hided Downloads Icon in Explorer Namespace"
    $WPFed40.IsChecked = $false
    }
        If ( $WPFed41.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Write-Host "Hided Music icon in Explorer Namespace"
    $WPFed41.IsChecked = $false
    }
        If ( $WPFed42.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Write-Host "Hided Pictures Icon in Explorer Namespace"
    $WPFed42.IsChecked = $false
    }
        If ( $WPFed43IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    Write-Host "Hided Videos Icon in Explorer Namespace"
    $WPFed43IsChecked.IsChecked = $false
    }
        If ( $WPFed44.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum" -Name "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" -Type DWord -Value 1
    Write-Host "Hided Network Icon in Explorer Namespace"
    $WPFed44.IsChecked = $false
    }

    Write-Host "All Selected Tweaks are activated successfully"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Taskbar ###################
##########################################

$WPFTab11P1.Add_Click({
    $WPFt1.IsChecked = $true
    $WPFt2.IsChecked = $true
    $WPFt3.IsChecked = $true
    $WPFt4.IsChecked = $true
    $WPFt5.IsChecked = $true
    $WPFt6.IsChecked = $true
    $WPFt7.IsChecked = $false
    $WPFt8.IsChecked = $false
    $WPFt9.IsChecked = $true
    $WPFt10.IsChecked = $false
    $WPFt11.IsChecked = $false
    $WPFt12.IsChecked = $true
    $WPFt13.IsChecked = $true
    $WPFt14.IsChecked = $true
    $WPFt15.IsChecked = $true
    $WPFt16.IsChecked = $false
    $WPFt17.IsChecked = $true
    $WPFt18.IsChecked = $false
    $WPFt19.IsChecked = $true
    $WPFt20.IsChecked = $false
    $WPFt21.IsChecked = $true
    $WPFt22.IsChecked = $true
    $WPFt23.IsChecked = $true
    $WPFt24.IsChecked = $false
    $WPFt25.IsChecked = $false
    $WPFt26.IsChecked = $false
    $WPFt27.IsChecked = $false
    $WPFt28.IsChecked = $false
    $WPFt29.IsChecked = $false
    $WPFt30.IsChecked = $false
    $WPFt31.IsChecked = $false
    $WPFt32.IsChecked = $false
    $WPFt33.IsChecked = $true
    $WPFt34.IsChecked = $false
    $WPFt35.IsChecked = $false
    $WPFt36.IsChecked = $false
    $WPFt37.IsChecked = $false
    $WPFt38.IsChecked = $false
    $WPFt39.IsChecked = $false
    $WPFt40.IsChecked = $false
    $WPFt41.IsChecked = $false
    $WPFt42.IsChecked = $false
    $WPFt44.IsChecked = $false
    $WPFt45.IsChecked = $false
    $WPFt46.IsChecked = $true
    $WPFt47.IsChecked = $false
    $WPFt48.IsChecked = $true
})

$WPFTab11P2.Add_Click({

        If ( $WPFt1.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
    Write-Host "Disabled 'Recent Elements' in Start Menu"
    $WPFt1.IsChecked = $false
    }
        If ( $WPFt2.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -Type DWord -Value 1
    Write-Host "Disabled 'Most Used' in Start Menu"
    $WPFt2.IsChecked = $false
    }
        If ( $WPFt3.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name ShellFeedsTaskbarViewMode -Type DWord -Value 2
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1    
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
    Stop-Service "WSearch" -WarningAction SilentlyContinue
    Set-Service "WSearch" -StartupType Disabled
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    Write-Host "Disabled Windows Search in Start Menu"
    $WPFt3.IsChecked = $false
    }
        If ( $WPFt4.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    Write-Host "Hided Task Icon in Taskbar"
    $WPFt4.IsChecked = $false
    }
        If ( $WPFt5.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
    Write-Host "Hided People Icon in Taskbar"
    $WPFt5.IsChecked = $false
    }
        If ( $WPFt6.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type dword -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "ForceEffectMode" -Type dword -Value 1
    Write-Host "Set Transparent Taskbar"
    $WPFt6.IsChecked = $false
    }
        If ( $WPFt7.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
    Write-Host "Showed All Tray Icon"
    $WPFt7.IsChecked = $false
    }
        If ( $WPFt8.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0
    Write-Host "Disabled Action Center"
    $WPFt8.IsChecked = $false
    }
        If ( $WPFt9.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
    Write-Host "Disabled Cortana"
    $WPFt9.IsChecked = $false
    }
        If ( $WPFt10.IsChecked -eq $true ) {
    Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme
    Write-Host "Set Light Theme"
    $WPFt10.IsChecked = $false
    }
        If ( $WPFt11.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -Type dword -Value 1
    Write-Host "Disabled AeroShake"
    $WPFt11.IsChecked = $false
    }
        If ( $WPFt12.IsChecked -eq $true ) {
    $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
    Do {
    Start-Sleep -Milliseconds 100
    $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
    } Until ($preferences)
    Stop-Process $taskmgr
    $preferences.Preferences[28] = 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
    Write-Host "Set Task Manager, Show Details"
    $WPFt12.IsChecked = $false
    }
        If ( $WPFt13.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
    Write-Host "Set Show Details Operation Files"
    $WPFt13.IsChecked = $false
    }
        If ( $WPFt14.IsChecked -eq $true ) {
    If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
    New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -Type DWord -Value 0
    Write-Host "Set Control Panel Icon View"
    $WPFt14.IsChecked = $false
    }
        If ( $WPFt15.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1
    Write-Host "Disabled Search for App in Store for Unknown Extensions"
    $WPFt15.IsChecked = $false
    }
        If ( $WPFt16.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -Type DWord -Value 1
    Write-Host "Disabled 'How do you want to open this file?' Prompt"
    $WPFt16.IsChecked = $false
    }
        If ( $WPFt17.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1
    Write-Host "Disabled Recent Files Lists"
    $WPFt17.IsChecked = $false
    }
        If ( $WPFt18.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -ErrorAction SilentlyContinue
    Write-Host "Disabled Clearing of Recent Files on Exit"
    $WPFt18.IsChecked = $false
    }
        If ( $WPFt19.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1
    Write-Host "Disabled Autoplay"
    $WPFt19.IsChecked = $false
    }
        If ( $WPFt20.IsChecked -eq $true ) {
    New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" -Name "TreatAsInternalPort"   -Type MultiString -Value 0,1,2,3,4,5
    Write-Host "Set Treat As Internal Port"
    $WPFt20.IsChecked = $false
    }
        If ( $WPFt21.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Type DWord -Value 255
    Write-Host "Disabled Autorun for All Drives"
    $WPFt21.IsChecked = $false
    }
        If ( $WPFt22.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
    Write-Host "Disabled Sticky Keys Prompt"
    $WPFt22.IsChecked = $false
    }
        If ( $WPFt23.IsChecked -eq $true ) {
    $Paint3Dstuff = @(
    "HKCR:\SystemFileAssociations\.3mf\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.bmp\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.fbx\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.gif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jfif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpe\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpeg\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.jpg\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.png\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.tif\Shell\3D Edit"
    "HKCR:\SystemFileAssociations\.tiff\Shell\3D Edit"
    )
    #Rename reg key to remove it, so it's revertible
    foreach ($Paint3D in $Paint3Dstuff) {
    If (Test-Path $Paint3D) {
    $rmPaint3D = $Paint3D + "_"
    Set-Item $Paint3D $rmPaint3D
    }
    }
    Write-Host "Disabled Paint3D"
    $WPFt23.IsChecked = $false
    }
        If ( $WPFt24.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -ErrorAction SilentlyContinue
    Write-Host "Enabled 'Recent Elements' in Start Menu"
    $WPFt24.IsChecked = $false
    }
        If ( $WPFt25.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoStartMenuMFUprogramsList" -ErrorAction SilentlyContinue
    Write-Host "Enabled 'Most Used' in Start Menu"
    $WPFt25.IsChecked = $false
    }
        If ( $WPFt26.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value "1"
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -ErrorAction SilentlyContinue
    Write-Host "Restore and Starting Windows Search Service..."
    Set-Service "WSearch" -StartupType Automatic
    Start-Service "WSearch" -WarningAction SilentlyContinue
    Write-Host "Restore Windows Search Icon..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
    Write-Host "Enabled Windows Search in Start Menu"
    $WPFt26.IsChecked = $false
    }
        If ( $WPFt27.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -ErrorAction SilentlyContinue
    Write-Host "Set Show Task Icon in Taskbar"
    $WPFt27.IsChecked = $false
    }
        If ( $WPFt28.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -ErrorAction SilentlyContinue
    Write-Host "Set Show People Icon in Taskbar"
    $WPFt28.IsChecked = $false
    }
        If ( $WPFt29.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseOLEDTaskbarTransparency" -Type dword -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "ForceEffectMode" -Type dword -Value 1
    Write-Host "Set Solid Taskbar"
    $WPFt29.IsChecked = $false
    }
        If ( $WPFt30.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -ErrorAction SilentlyContinue 
    Write-Host "Set Hide All Tray Icon"
    $WPFt30.IsChecked = $false
    }
        If ( $WPFt31.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -ErrorAction SilentlyContinue 
    Write-Host "Enabled Action Center"
    $WPFt31.IsChecked = $false
    }
        If ( $WPFt32.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -ErrorAction SilentlyContinue
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 0
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -ErrorAction SilentlyContinue 
    Write-Host "Enabled Cortana"
    $WPFt32.IsChecked = $false
    }
        If ( $WPFt33.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Write-Host "Set Dark Theme"
    $WPFt33.IsChecked = $false
    }
        If ( $WPFt34.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -ErrorAction SilentlyContinue
    Write-Host "Enabled AeroShake"
    $WPFt34.IsChecked = $false
    }
        If ( $WPFt35.IsChecked -eq $true ) {
    $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
    If ($preferences) {
    $preferences.Preferences[28] = 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences
    }
    Write-Host "Set Task Manager, Hide Details"
    $WPFt35.IsChecked = $false
    }
        If ( $WPFt36.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -ErrorAction SilentlyContinue
    Write-Host "Hided Details Operation Files"
    $WPFt36.IsChecked = $false
    }
        If ( $WPFt37.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -ErrorAction SilentlyContinue
    Write-Host "Set Control Panel Categories View"
    $WPFt37.IsChecked = $false
    }
        If ( $WPFt38.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -ErrorAction SilentlyContinue
    Write-Host "Enabled Search for App in Store for Unknown Extensions"
    $WPFt38.IsChecked = $false
    }
        If ( $WPFt39.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoNewAppAlert" -ErrorAction SilentlyContinue
    Write-Host "Enabled 'How do you want to open this file?' Prompt"
    $WPFt39.IsChecked = $false
    }
        If ( $WPFt40.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -ErrorAction SilentlyContinue
    Write-Host "Enabled Recent Files Lists"
    $WPFt40.IsChecked = $false
    }
        If ( $WPFt41.IsChecked -eq $true ) {
    If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -Type DWord -Value 1
    Write-Host "Enabled Clearing of Recent Files on Exit"
    $WPFt41.IsChecked = $false
    }
        If ( $WPFt42.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 0
    Write-Host "Enabled Autoplay"
    $WPFt42.IsChecked = $false
    }
        If ( $WPFt44.IsChecked -eq $true ) {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -ErrorAction SilentlyContinue
    Write-Host "Enable Autorun for All Drives"
    $WPFt44.IsChecked = $false
    }
        If ( $WPFt45.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "510"
    Write-Host "Enable Sticky Keys Prompt"
    $WPFt45.IsChecked = $false
    }
        If ( $WPFt46.IsChecked -eq $true ) {
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
 If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
        If (!(Test-Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag")) {
            New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -Type String -Value "Hide"
    
    Write-Host "Disabled 3D Object"
    $WPFt46.IsChecked = $false
    }
        If ( $WPFt47.IsChecked -eq $true ) {
If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" | Out-Null
        }
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" -Name "ThisPCPolicy" -ErrorAction SilentlyContinue
    
    Write-Host "Enabled 3D Object"
    $WPFt47.IsChecked = $false
    }

        If ( $WPFt48.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
    Write-Host "Disabled News and Interest"
    $WPFt48.IsChecked = $false
    }

            If ( $WPFt49.IsChecked -eq $true ) {
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 0
    Write-Host "Enabled News and Interest"
    $WPFt49.IsChecked = $false
    }

    Write-Host "All Selected Tweaks are activated successfully"
    $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Completed"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

##########################################
############## Repair PC #################
##########################################

$WPFTab12P1.Add_Click({
	control appwiz.cpl
})

$WPFTab12P2.Add_Click({
	powercfg.cpl
})

$WPFTab12P3.Add_Click({
	control printers
})

$WPFTab12P4.Add_Click({
	control mmsys.cpl
})

$WPFTab12P5.Add_Click({
	ncpa.cpl
})

$WPFTab12P6.Add_Click({
	control.exe /name Microsoft.NetworkandSharingCenter
})

$WPFTab12P7.Add_Click({
	sysdm.cpl
})

$WPFTab12P8.Add_Click({
	services.msc
})

$WPFTab12P9.Add_Click({
	regedit.exe
})

$WPFTab12P10.Add_Click({
	msconfig.exe
})

$WPFTab12P11.Add_Click({
	dcomcnfg
})

$WPFTab12P12.Add_Click({
	devmgmt.msc
})

$WPFTab12P13.Add_Click({
	control nusrmgr.cpl
})

$WPFTab12P14.Add_Click({
	compmgmt.msc /s
})

$WPFTab12P15.Add_Click({
	colorcpl
})

$WPFTab12P16.Add_Click({
	control.exe /name Microsoft.CredentialManager
})

$WPFTab12P17.Add_Click({
	control.exe /name Microsoft.DefaultPrograms
})

$WPFTab12P18.Add_Click({
	control folders
})

$WPFTab12P19.Add_Click({
	control.exe /name Microsoft.TaskbarandStartMenu
})

$WPFTab12P20.Add_Click({
	control desk.cpl
})

$WPFTab12P21.Add_Click({
	msinfo32.exe
})

$WPFTab12P22.Add_Click({
	taskschd.msc /s
})

$WPFTab12P23.Add_Click({
	Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k slmgr /dli}
})

$WPFTab12P24.Add_Click({
	Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k cscript "C:\Program Files\Microsoft Office\Office16\ospp.vbs" /dstatus}
})

$WPFTab12P25.Add_Click({
	powercfg /batteryreport /output "C:\battery-report.html"
	Write-Host "Troverai il report in C:\" 
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Troverai il Report in C:\"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab12P26.Add_Click({
	New-Item -Path 'C:\Drivers' -ItemType Directory
    DISM.exe /Online /Export-Driver /Destination:C:\Drivers
    Write-host "Troverai i Tuoi Driver nella cartella C:\Drivers"
        $WPFResult.ToArray()
    $WPFResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Result"
    $Messageboxbody = "Troverai i tuoi driver nella cartella C:\Drivers"
    $MessageIcon = [System.Windows.MessageBoxImage]::Information
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$WPFTab12P27.Add_Click({
    netsh winsock reset
    netsh int ip reset
    ipconfig /release
    ipconfig /renew
    ipconfig /flushdns
    ipconfig /release6
    ipconfig /renew6 *Ethernet*
    ipconfig /renew *Ethernet*
    netsh advfirewall reset
})

$WPFTab12P28.Add_Click({
	Start-Process wsreset -NoNewWindow
})

$WPFTab12P29.Add_Click({
	Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k dism.exe /online /cleanup-image /restorehealth} 
})

$WPFTab12P30.Add_Click({
	Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/k sfc /scannow}   
})

$WPFTab12P31.Add_Click({
    $wingetinstall = New-Object System.Collections.Generic.List[System.Object]
        If ( $WPFr1.IsChecked -eq $true ) {
    $wingetinstall.Add("CPUID.CPU-Z")
    $WPFr1.IsChecked = $false
    }
        If ( $WPFr2.IsChecked -eq $true ) {
    $wingetinstall.Add("TechPowerUp.GPU-Z")
    $WPFr2.IsChecked = $false
    }
        If ( $WPFr3.IsChecked -eq $true ) {
    $wingetinstall.Add("CrystalDewWorld.CrystalDiskInfo")
    $WPFr3.IsChecked = $false
    }
        If ( $WPFr4.IsChecked -eq $true ) {
    $wingetinstall.Add("CrystalDewWorld.CrystalDiskMark")
    $WPFr4.IsChecked = $false
    }
        If ( $WPFr5.IsChecked -eq $true ) {
    $wingetinstall.Add("REALiX.HWiNFO")
    $WPFr5.IsChecked = $false
    }
        If ( $WPFr6.IsChecked -eq $true ) {
    Start-BitsTransfer -Source "https://download.sysinternals.com/files/TCPView.zip" -Destination "C:\Users\Public\Desktop"
    $WPFr6.IsChecked = $false
    }
        If ( $WPFr7.IsChecked -eq $true ) {
    Start-BitsTransfer -Source "https://download.sysinternals.com/files/SysinternalsSuite.zip" -Destination "C:\Users\Public\Desktop"
    $WPFr7.IsChecked = $false
    }
        If ( $WPFr8.IsChecked -eq $true ) {
    Start-BitsTransfer -Source "https://download.sysinternals.com/files/ProcessExplorer.zip" -Destination "C:\Users\Public\Desktop"
    $WPFr8.IsChecked = $false
    }
        If ( $WPFr9.IsChecked -eq $true ) {
    start "https://www.techpowerup.com/download/counter-control/"
    $WPFr9.IsChecked = $false
    }
        If ( $WPFr10.IsChecked -eq $true ) {
    $wingetinstall.Add("ALCPU.CoreTemp")
    $WPFr10.IsChecked = $false
    }
        If ( $WPFr11.IsChecked -eq $true ) {
    $wingetinstall.Add("Piriform.Speccy")
    $WPFr11.IsChecked = $false
    }
        If ( $WPFr12.IsChecked -eq $true ) {
    $wingetinstall.Add("KCSoftwares.SUMo")
    $WPFr12.IsChecked = $false
    }
        If ( $WPFr13.IsChecked -eq $true ) {
    Start-Process powershell.exe -ArgumentList "Start-BitsTransfer -Source 'https://www.ocbase.com/download/edition:Personal' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
    $WPFr13.IsChecked = $false
    }
        If ( $WPFr14.IsChecked -eq $true ) {
    $wingetinstall.Add("FinalWire.AIDA64.Extreme")
    $WPFr14.IsChecked = $false
    }
        If ( $WPFr15.IsChecked -eq $true ) {
    start "https://www.techpowerup.com/download/techpowerup-throttlestop/"
    $WPFr15.IsChecked = $false
    }
        If ( $WPFr16.IsChecked -eq $true ) {
    Start-Process powershell.exe -ArgumentList "Start-BitsTransfer -Source 'https://download.sysinternals.com/files/Autoruns.zip' -Destination 'C:\Users\Public\Desktop'" -Wait -WindowStyle Maximized
    $WPFr16.IsChecked = $false
    }
        If ( $WPFr17.IsChecked -eq $true ) {
    $wingetinstall.Add("WiresharkFoundation.Wireshark")
    $WPFr17.IsChecked = $false
    }
        If ( $WPFr18.IsChecked -eq $true ) {
    $wingetinstall.Add("BleachBit.BleachBit")
    $WPFr18.IsChecked = $false
    }
        If ( $WPFr19.IsChecked -eq $true ) {
    $wingetinstall.Add("Glarysoft.GlaryUtilities")
    $WPFr19.IsChecked = $false
    }
        If ( $WPFr20.IsChecked -eq $true ) {
    $wingetinstall.Add("Piriform.CCleaner")
    $WPFr20.IsChecked = $false
    }
        If ( $WPFr21.IsChecked -eq $true ) {
    $wingetinstall.Add("RevoUninstaller.RevoUninstaller")
    $WPFr21.IsChecked = $false
    }
        If ( $WPFr22.IsChecked -eq $true ) {
    $wingetinstall.Add("Klocman.BulkCrapUninstaller")
    $WPFr22.IsChecked = $false
    }
        If ( $WPFr23.IsChecked -eq $true ) {
    $wingetinstall.Add("Microsoft.dotNetFramework")
    $WPFr23.IsChecked = $false
    }
        If ( $WPFr24.IsChecked -eq $true ) {
    $wingetinstall.Add("Microsoft.VC++2017Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2017Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2015Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2015Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2015-2022Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2015-2022Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2015-2019Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2015-2019Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2013Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2013Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2012Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2012Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2010Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2010Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2008Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2008Redist-x64")
    $wingetinstall.Add("Microsoft.VC++2005Redist-x86")
    $wingetinstall.Add("Microsoft.VC++2005Redist-x64")
    $WPFr24.IsChecked = $false
    }
        If ( $WPFr25.IsChecked -eq $true ) {
    $wingetinstall.Add("Paragon.ParagonBackupRecoveryCE")
    $WPFr25.IsChecked = $false
    }
        If ( $WPFr26.IsChecked -eq $true ) {
    $wingetinstall.Add("MiniTool.PartitionWizard.Free")
    $WPFr26.IsChecked = $false
    }
        If ( $WPFr27.IsChecked -eq $true ) {
    $wingetinstall.Add("EaseUS.PartitionMaster")
    $WPFr27.IsChecked = $false
    }
        If ( $WPFr28.IsChecked -eq $true ) {
    $wingetinstall.Add("AOMEI.PartitionAssistant")
    $WPFr28.IsChecked = $false
    }
        If ( $WPFr29.IsChecked -eq $true ) {
    $wingetinstall.Add("Piriform.Recuva")
    $WPFr29.IsChecked = $false
    }
    $wingetinstall.ToArray()
    $wingetResult = New-Object System.Collections.Generic.List[System.Object]
    foreach ( $node in $wingetinstall )
    {
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-command winget install -e --accept-source-agreements --accept-package-agreements --silent $node | Out-Host" -Wait -WindowStyle Maximized
    $wingetResult.Add("$node`n")
    }
    $wingetResult.ToArray()
    $wingetResult | % { $_ } | Out-Host
    $ButtonType = [System.Windows.MessageBoxButton]::OK
    $MessageboxTitle = "Installed "
    $Messageboxbody = ($wingetResult)
    $MessageIcon = [System.Windows.MessageBoxImage]::Information

    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$MessageIcon)
})

$Form.ShowDialog() | out-null
