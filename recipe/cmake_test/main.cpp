#include <fastdds/dds/domain/DomainParticipantFactory.hpp>

int main() {
    return eprosima::fastdds::dds::DomainParticipantFactory::get_instance() == nullptr;
}
