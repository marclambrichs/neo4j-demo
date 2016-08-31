Facter.add(:java_version) do
  setcode do
    %x{/usr/bin/java -version 2>&1 | /usr/bin/head -n 1 | /usr/bin/cut -f2 -d '"'}.chomp
  end
end
