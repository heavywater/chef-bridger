package 'bridge-utils'

[[node[:bridger]] + node[:bridger][:additionals]].each do |bridge|
  # Lets build a bridge!
  # TODO: flush here?
  execute "bridger[kill the interface (#{bridge[:interface]})]" do
    command "ifconfig #{bridge[:interface]} 0.0.0.0"
    not_if do
      system("ip addr show #{bridge[:name]} > /dev/null 2>&1")
    end
  end

  execute "bridger[create the bridge (#{bridge[:name]})]" do
    command "brctl addbr #{bridge[:name]}"
    action :nothing
    subscribes :run, resources(:execute => 'bridger[kill the network]'), :immediately
  end

  execute "bridger[bind the bridge (#{bridge[:name]} -> #{bridge[:interface]})]" do
    command "brctl addif #{bridge[:name]} #{bridge[:interface]}"
    action :nothing
    subscribes :run, resources(:execute => 'bridger[kill the network]'), :immediately
  end

  if(bridge[:dhcp])
    execute "bridger[configure the bridge (#{bridge[:name]} - dynamic)]" do
      command "dhclient #{bridge[:name]}"
      action :nothing
      subscribes :run, resources(:execute => 'bridger[kill the network]'), :immediately
    end
  else
    execute "bridger[configure the bridge (#{bridge[:name]} - static)]" do
      command "ifconfig #{bridge[:name]} #{bridge[:address]} netmask #{bridge[:netmask]}"
      action :nothing
      subscribes :run, resources(:execute => 'bridger[kill the network]'), :immediately
    end
  end
  # YAY we built a bridge!
end
