-- V53: Add reference_conversation_id to root_user_scenarios
-- 시나리오 생성자가 저장한 "기준 대화" ID
-- 다른 사용자가 포크할 때 이 대화의 메시지를 복사하여 컨텍스트 유지

ALTER TABLE root_user_scenarios
ADD COLUMN reference_conversation_id UUID REFERENCES conversations(id) ON DELETE SET NULL;

-- 인덱스 추가
CREATE INDEX idx_root_scenarios_ref_conv ON root_user_scenarios(reference_conversation_id);

-- 코멘트 추가
COMMENT ON COLUMN root_user_scenarios.reference_conversation_id IS '기준 대화 ID - 포크 시 이 대화의 메시지를 복사하여 컨텍스트 유지';

